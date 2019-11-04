-- This file is generated by tools/json2lua.js

local ffxiv_ipc_ping = Proto("ffxiv_ipc_ping", "FFXIV-IPC Ping")

local ping_fields = {
  timestamp = ProtoField.uint64("ffxiv_ipc_ping.timestamp", "Timestamp", base.DEC),
  unknown1  = ProtoField.uint32("ffxiv_ipc_ping.unknown1", "Unknown1", base.DEC),
  unknown2  = ProtoField.uint32("ffxiv_ipc_ping.unknown2", "Unknown2", base.DEC),
}

ffxiv_ipc_ping.fields = ping_fields

function ffxiv_ipc_ping.dissector(tvbuf, pktinfo, root)
  local tree = root:add(ffxiv_ipc_ping, tvbuf)

  -- dissect the timestamp field
  local timestamp_tvbr = tvbuf:range(0, 8)
  local timestamp_val  = timestamp_tvbr:le_uint64()
  tree:add_le(ping_fields.timestamp, timestamp_tvbr)

  -- dissect the unknown1 field
  local unknown1_tvbr = tvbuf:range(8, 4)
  local unknown1_val  = unknown1_tvbr:le_uint()
  tree:add_le(ping_fields.unknown1, unknown1_tvbr)

  -- dissect the unknown2 field
  local unknown2_tvbr = tvbuf:range(12, 4)
  local unknown2_val  = unknown2_tvbr:le_uint()
  tree:add_le(ping_fields.unknown2, unknown2_tvbr)


  pktinfo.cols.info:set("Ping")
  return tvbuf:len()
end