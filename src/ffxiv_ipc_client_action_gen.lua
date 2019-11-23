-- This file is generated by tools/json2lua.js

local db = require('ffxiv_db')
local enum = require('ffxiv_enum')
local ffxiv_ipc_client_action = Proto("ffxiv_ipc_client_action", "FFXIV-IPC ClientAction")

local client_action_fields = {
  unknown1 = ProtoField.uint32("ffxiv_ipc_client_action.unknown1", "Unknown1", base.DEC),
  unknown2 = ProtoField.uint32("ffxiv_ipc_client_action.unknown2", "Unknown2", base.DEC),
  type     = ProtoField.uint16("ffxiv_ipc_client_action.type", "Type", base.DEC, enum.reverse.client_action_type),
  unknown3 = ProtoField.uint16("ffxiv_ipc_client_action.unknown3", "Unknown3", base.DEC),
  action   = ProtoField.uint32("ffxiv_ipc_client_action.action", "Action", base.DEC, db.Action),
  unknown4 = ProtoField.uint32("ffxiv_ipc_client_action.unknown4", "Unknown4", base.DEC),
  unknown5 = ProtoField.uint32("ffxiv_ipc_client_action.unknown5", "Unknown5", base.DEC),
}

ffxiv_ipc_client_action.fields = client_action_fields

function ffxiv_ipc_client_action.dissector(tvbuf, pktinfo, root)
  local tree = root:add(ffxiv_ipc_client_action, tvbuf)
  pktinfo.cols.info:set("ClientAction")


  -- dissect the unknown1 field
  local unknown1_tvbr = tvbuf:range(0, 4)
  local unknown1_val  = unknown1_tvbr:le_uint()
  tree:add_le(client_action_fields.unknown1, unknown1_tvbr, unknown1_val)

  -- dissect the unknown2 field
  local unknown2_tvbr = tvbuf:range(4, 4)
  local unknown2_val  = unknown2_tvbr:le_uint()
  tree:add_le(client_action_fields.unknown2, unknown2_tvbr, unknown2_val)

  -- dissect the type field
  local type_tvbr = tvbuf:range(8, 2)
  local type_val  = type_tvbr:le_uint()
  tree:add_le(client_action_fields.type, type_tvbr, type_val)

  -- dissect the unknown3 field
  local unknown3_tvbr = tvbuf:range(10, 2)
  local unknown3_val  = unknown3_tvbr:le_uint()
  tree:add_le(client_action_fields.unknown3, unknown3_tvbr, unknown3_val)

  -- dissect the action field
  local action_tvbr = tvbuf:range(12, 4)
  local action_val  = action_tvbr:le_uint()
  tree:add_le(client_action_fields.action, action_tvbr, action_val)

  -- dissect the unknown4 field
  local unknown4_tvbr = tvbuf:range(16, 4)
  local unknown4_val  = unknown4_tvbr:le_uint()
  tree:add_le(client_action_fields.unknown4, unknown4_tvbr, unknown4_val)

  -- dissect the unknown5 field
  local unknown5_tvbr = tvbuf:range(20, 4)
  local unknown5_val  = unknown5_tvbr:le_uint()
  tree:add_le(client_action_fields.unknown5, unknown5_tvbr, unknown5_val)


  return tvbuf:len()
end