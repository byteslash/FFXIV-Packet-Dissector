
const fs = require('fs')
let files = fs.readdirSync('./js')

const snakeCase = name => name.replace(/\s*([A-Z]+)/g, (m0, m1, index) => `${index ? '_' : ''}${m1.toLowerCase()}`)
const tvb_method = function (type) {
  if (type.startsWith('uint')) {
    return type === 'uint64' ? 'le_uint64' : 'le_uint'
  } else if (type === 'float') {
    return 'le_float'
  }

  return type
}

const generateLuaDissector = function (name, obj) {
  let fields = obj.fields || (obj.structs && obj.structs[0] && obj.structs[0].fields)
  if (!fields || !fields.length) return ''
  let requireDB = false
  fields.forEach(item => {
    item.key = snakeCase(item.name)
    if (item.enum) {
      if (item.enum.startsWith('$')) {
        item.enum = item.enum.replace('$', 'db.')
        requireDB = true
      } else {
        item.enum = snakeCase(item.enum) + '_valstr'
      }
    }
  })

  let maxLength = fields.reduce((max, item) => Math.max(max, item.key.length), 0)
  return `-- This file is generated by tools/json2lua.js
${requireDB ? `
local db = require('ffxiv_db')` : ''}
local ffxiv_ipc_${name} = Proto("ffxiv_ipc_${name}", "FFXIV-IPC ${obj.name}")
${obj.enums.length ? `
local function makeValString(enumTable)
  local t = {}
  for name,num in pairs(enumTable) do
      t[num] = name
  end
  return t
end
${obj.enums.map(item => `
local ${snakeCase(item.name)} = {${item.values.map(({ key, value }) => `
  ${key} = ${value},`).join('')}
}`).join('\n')}
${obj.enums.map(item => `
local ${snakeCase(item.name)}_valstr = makeValString(${snakeCase(item.name)})`).join('')}
` : ''}
local ${name}_fields = {${fields.map(item => `
  ${item.key}${' '.repeat(maxLength - item.key.length)} = ProtoField.${item.type}("ffxiv_ipc_${name}.${
  item.key}", "${item.name}", base.${item.base || 'DEC'}${item.enum ? `, ${item.enum}` : ''}),`).join('')}
}

ffxiv_ipc_${name}.fields = ${name}_fields

function ffxiv_ipc_${name}.dissector(tvbuf, pktinfo, root)
  local tree = root:add(ffxiv_ipc_${name}, tvbuf)
${fields.map(item => `
  -- dissect the ${item.key} field
  local ${item.key}_tvbr = tvbuf:range(${item.offset}${item.length ? `, ${item.length}` : ''})
  local ${item.key}_val  = ${item.key}_tvbr:${item.tvb_method || `${tvb_method(item.type)}()`}
  tree:${item.add_le === false ? 'add' : 'add_le'}(${name}_fields.${item.key}, ${item.key}_${item.add_val === true ? 'val' : 'tvbr'})
`).join('')}

  pktinfo.cols.info:set("${obj.name}")
  return tvbuf:len()
end`
}

const ipcTypes = []

for (let file of files) {
  const obj = JSON.parse(fs.readFileSync('./js/' + file))
  const name = snakeCase(obj.name || file.replace('.json', ''))

  if (obj.name) {
    ipcTypes.push({
      name: obj.name.replace(/ /g, ''),
      type: obj.type,
      version: obj.version
    })
  }

  fs.writeFileSync(`../src/ffxiv_ipc_${name}_gen.lua`, generateLuaDissector(name, obj))
}

let ipcContent = fs.readFileSync('../src/ffxiv_ipc.lua', 'utf-8')
let replaceContent = function (startTag, endTag, replaceWith) {
  ipcContent = ipcContent.replace(new RegExp(`-- ${startTag}[\\s\\S]+-- ${endTag}`, 'g'), () => {
    return `-- ${startTag}\n${replaceWith}\n-- ${endTag}`
  })
}

replaceContent(
  '#ipc enum starts#',
  '#ipc enum ends#',
  ipcTypes.map(item => `  ${item.name} = ${
    typeof item.type === 'number' ? `0x${('000' + item.type.toString(16)).substr(-4)}` : item.type
  },${item.version ? ` -- ${item.version}` : ''}`).join('\n')
)

replaceContent(
  '#ipc condition starts#',
  '#ipc condition ends#',
  '  ' + ipcTypes.map(({ name }) => `if type_val == ipc_type.${name} then
    Dissector.get('ffxiv_ipc_${snakeCase(name)}'):call(tvb, pktinfo, root)
  else`).join('')
)

fs.writeFileSync('../src/ffxiv_ipc.lua', ipcContent)
