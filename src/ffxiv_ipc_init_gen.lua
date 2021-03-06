-- This file is generated by tools/json2lua.js

local ffxiv_ipc_init = Proto("ffxiv_ipc_init", "FFXIV-IPC Init")

local init_fields = {
  unknown  = ProtoField.uint64("ffxiv_ipc_init.unknown", "unknown", base.DEC),
  char_id  = ProtoField.uint32("ffxiv_ipc_init.char_id", "charId", base.DEC),
  unknown1 = ProtoField.uint32("ffxiv_ipc_init.unknown1", "unknown1", base.DEC),
}

ffxiv_ipc_init.fields = init_fields

function ffxiv_ipc_init.dissector(tvbuf, pktinfo, root)
  local tree = root:add(ffxiv_ipc_init, tvbuf)
  pktinfo.cols.info:set("Init")

  local len = tvbuf:len()

  -- dissect the unknown field
  local unknown_tvbr = tvbuf:range(0, 8)
  local unknown_val  = unknown_tvbr:le_uint64()
  tree:add_le(init_fields.unknown, unknown_tvbr, unknown_val)

  -- dissect the char_id field
  local char_id_tvbr = tvbuf:range(8, 4)
  local char_id_val  = char_id_tvbr:le_uint()
  tree:add_le(init_fields.char_id, char_id_tvbr, char_id_val)

  -- dissect the unknown1 field
  local unknown1_tvbr = tvbuf:range(12, 4)
  local unknown1_val  = unknown1_tvbr:le_uint()
  tree:add_le(init_fields.unknown1, unknown1_tvbr, unknown1_val)

  return len
end