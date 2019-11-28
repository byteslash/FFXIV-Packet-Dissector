-- This file is generated by tools/json2lua.js

local enum = require('ffxiv_enum')
local ffxiv_ipc_fish_event = Proto("ffxiv_ipc_fish_event", "FFXIV-IPC Fish Event")

local fish_event_fields = {
  user_id   = ProtoField.uint32("ffxiv_ipc_fish_event.user_id", "UserId", base.HEX),
  unknown1  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown1", "Unknown1", base.DEC),
  unknown2  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown2", "Unknown2", base.DEC),
  unknown3  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown3", "Unknown3", base.DEC),
  unknown4  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown4", "Unknown4", base.DEC),
  type      = ProtoField.uint16("ffxiv_ipc_fish_event.type", "Type", base.DEC, enum.reverse.fish_event_type),
  unknown5  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown5", "Unknown5", base.DEC),
  unknown7  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown7", "Unknown7", base.DEC),
  unknown8  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown8", "Unknown8", base.DEC),
  unknown9  = ProtoField.uint16("ffxiv_ipc_fish_event.unknown9", "Unknown9", base.DEC),
  unknown10 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown10", "Unknown10", base.DEC),
  unknown11 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown11", "Unknown11", base.DEC),
  unknown12 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown12", "Unknown12", base.DEC),
  unknown13 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown13", "Unknown13", base.DEC),
  unknown14 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown14", "Unknown14", base.DEC),
  unknown15 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown15", "Unknown15", base.DEC),
  unknown16 = ProtoField.uint16("ffxiv_ipc_fish_event.unknown16", "Unknown16", base.DEC),
}

ffxiv_ipc_fish_event.fields = fish_event_fields

function ffxiv_ipc_fish_event.dissector(tvbuf, pktinfo, root)
  local tree = root:add(ffxiv_ipc_fish_event, tvbuf)
  pktinfo.cols.info:set("Fish Event")

  -- dissect the user_id field
  local user_id_tvbr = tvbuf:range(0, 4)
  local user_id_val  = user_id_tvbr:le_uint()
  tree:add_le(fish_event_fields.user_id, user_id_tvbr, user_id_val)

  -- dissect the unknown1 field
  local unknown1_tvbr = tvbuf:range(4, 2)
  local unknown1_val  = unknown1_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown1, unknown1_tvbr, unknown1_val)

  -- dissect the unknown2 field
  local unknown2_tvbr = tvbuf:range(6, 2)
  local unknown2_val  = unknown2_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown2, unknown2_tvbr, unknown2_val)

  -- dissect the unknown3 field
  local unknown3_tvbr = tvbuf:range(8, 2)
  local unknown3_val  = unknown3_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown3, unknown3_tvbr, unknown3_val)

  -- dissect the unknown4 field
  local unknown4_tvbr = tvbuf:range(10, 2)
  local unknown4_val  = unknown4_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown4, unknown4_tvbr, unknown4_val)

  -- dissect the type field
  local type_tvbr = tvbuf:range(12, 2)
  local type_val  = type_tvbr:le_uint()
  tree:add_le(fish_event_fields.type, type_tvbr, type_val)

  local type_display = ", Type: " .. (enum.reverse.fish_event_type[type_val] or "(unknown)")
  pktinfo.cols.info:append(type_display)
  tree:append_text(type_display)

  -- dissect the unknown5 field
  local unknown5_tvbr = tvbuf:range(14, 2)
  local unknown5_val  = unknown5_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown5, unknown5_tvbr, unknown5_val)

  -- dissect the unknown7 field
  local unknown7_tvbr = tvbuf:range(16, 2)
  local unknown7_val  = unknown7_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown7, unknown7_tvbr, unknown7_val)

  -- dissect the unknown8 field
  local unknown8_tvbr = tvbuf:range(18, 2)
  local unknown8_val  = unknown8_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown8, unknown8_tvbr, unknown8_val)

  -- dissect the unknown9 field
  local unknown9_tvbr = tvbuf:range(20, 2)
  local unknown9_val  = unknown9_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown9, unknown9_tvbr, unknown9_val)

  -- dissect the unknown10 field
  local unknown10_tvbr = tvbuf:range(22, 2)
  local unknown10_val  = unknown10_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown10, unknown10_tvbr, unknown10_val)

  -- dissect the unknown11 field
  local unknown11_tvbr = tvbuf:range(24, 2)
  local unknown11_val  = unknown11_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown11, unknown11_tvbr, unknown11_val)

  -- dissect the unknown12 field
  local unknown12_tvbr = tvbuf:range(26, 2)
  local unknown12_val  = unknown12_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown12, unknown12_tvbr, unknown12_val)

  -- dissect the unknown13 field
  local unknown13_tvbr = tvbuf:range(28, 2)
  local unknown13_val  = unknown13_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown13, unknown13_tvbr, unknown13_val)

  -- dissect the unknown14 field
  local unknown14_tvbr = tvbuf:range(30, 2)
  local unknown14_val  = unknown14_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown14, unknown14_tvbr, unknown14_val)

  -- dissect the unknown15 field
  local unknown15_tvbr = tvbuf:range(32, 2)
  local unknown15_val  = unknown15_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown15, unknown15_tvbr, unknown15_val)

  -- dissect the unknown16 field
  local unknown16_tvbr = tvbuf:range(34, 2)
  local unknown16_val  = unknown16_tvbr:le_uint()
  tree:add_le(fish_event_fields.unknown16, unknown16_tvbr, unknown16_val)

  return tvbuf:len()
end