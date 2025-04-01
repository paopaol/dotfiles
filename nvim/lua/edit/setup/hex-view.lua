local ffi = require("ffi")
local bit = require("bit")



local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos "'<")
  local _, cerow, cecol, _ = unpack(vim.fn.getpos "'>")

  local start_row, start_col, end_row, end_col

  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    start_row = csrow
    start_col = cscol
    end_row = cerow
    end_col = cecol
  else
    start_row = cerow
    start_col = cecol
    end_row = csrow
    end_col = cscol
  end

  return start_row, start_col, end_row, end_col
end

--   4640e666           abcd       12345.6
--   e6664640           cdab       12345.6
--   404666e6           badc       12345.6
--   66e64046           dcba       12345.6
--   40c387feb851eb85   abcdefgh   9999.99
--   eb85b85187fe40c3   ghefcdab   9999.99
--   c340fe8751b885eb   badcfehg   9999.99
--   85eb51b8fe87c340   hgfedcba   9999.99
--   ffffcfc7           abcd       -12345
--   cfc7ffff           cdab       -12345


local union_type = ffi.typeof [[
union {
  uint64_t u64;
  int64_t i64;

  uint32_t u32;
  int32_t i32;

  uint16_t u16;
  int16_t i16;

  float f;
  double d;
}
]]

local M = {}


local byteorder = {
  ab_to_ab = function(hex_str)
    return hex_str
  end,
  ba_to_ab = function(hex_str)
    return hex_str:gsub("(.)(.)(.)(.)", "%3%4%1%2")
  end,
  cdab_to_abcd = function(hex_str)
    return hex_str:gsub("(.)(.)(.)(.)(.)(.)(.)(.)", "%5%6%7%8%1%2%3%4")
  end,
  badc_to_abcd = function(hex_str)
    return hex_str:gsub("(.)(.)(.)(.)(.)(.)(.)(.)", "%3%4%1%2%7%8%5%6")
  end,
  dcba_to_abcd = function(hex_str)
    return hex_str:gsub("(.)(.)(.)(.)(.)(.)(.)(.)", "%7%8%5%6%3%4%1%2")
  end,
  ghefcdab_to_abcdefgh = function(hex_str)
    return hex_str:gsub("(..)(..)(..)(..)(..)(..)(..)(..)", "%7%8%5%6%3%4%1%2")
  end,
  badcfehg_to_abcdefgh = function(hex_str)
    return hex_str:gsub("(..)(..)(..)(..)(..)(..)(..)(..)", "%2%1%4%3%6%5%8%7")
  end,
  hgfedcba_to_abcdefgh = function(hex_str)
    return hex_str:gsub("(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1")
  end
}



local function hex_tonumber2_abcd(hex_str)
  local union = union_type {}
  union.u64 = tonumber(hex_str, 16)

  local result = {}

  result["hex"] = hex_str
  result["uint16"] = union.u16 or 0
  result["int16"] = union.i16 or 0

  return result
end

local function hex_tonumber4_abcd(hex_str)
  local union = union_type {}

  union.u64 = tonumber(hex_str, 16) or 0

  local result = {}

  result["hex"] = hex_str
  result["uint32"] = union.u32 or 0
  result["int32"] = union.i32
  result["float"] = union.f or 0.0

  return result
end

local function hex_tonumber8_abcd(hex_str)
  local union = union_type {}
  union.u64 = tonumber(hex_str, 16)

  local result = {}

  result["hex"] = hex_str
  result["uint64"] = union.u64 or 0
  result["int64"] = union.i64 or 0
  result["double"] = union.d or 0.0

  return result
end

local function byteorder_to_abcd(hex_str, kind)
  local map = {
    ab = byteorder.ab_to_ab,
    ba = byteorder.ba_to_ab,
    abcd = byteorder.ab_to_ab,
    dcba = byteorder.dcba_to_abcd,
    cdab = byteorder.cdab_to_abcd,
    badc = byteorder.badc_to_abcd,
    abcdefgh = byteorder.ab_to_ab,
    ghefcdab = byteorder.ghefcdab_to_abcdefgh,
    badcfehg = byteorder.badcfehg_to_abcdefgh,
    hgfedcba = byteorder.hgfedcba_to_abcdefgh,
  }

  return map[kind](hex_str)
end

local function hex_tonumber(hex_str, kind)
  local convert = {
    [4] = hex_tonumber2_abcd,
    [8] = hex_tonumber4_abcd,
    [16] = hex_tonumber8_abcd,
  }

  hex_str = byteorder_to_abcd(hex_str, kind)
  return {
    type = kind,
    view = convert[#hex_str](hex_str)
  }
end

local function numberToBinStr(x)
  local ret = ""
  while x ~= 1 and x ~= 0 do
    ret = tostring(x % 2) .. ret
    x = math.modf(x / 2)
  end
  ret = tostring(x) .. ret
  return ret
end

M.hex_view = function(hex_str)
  local header = {
    [4] = { "||uint16|int16|bit|", "|--|--|--|--|" },
    [8] = { "||float|uint32|int32|bit|", "|-|-|-|-|-|" },
    [16] = { "||double|uint64|int64|bit|", "|-|-|-|-|-|" }
  }

  local formater = {
    [4] = function(kind, data)
      return string.format("|%s|%u|%d|%s|", kind, data["uint16"], data["int16"],
        numberToBinStr(data["uint16"]))
    end,
    [8] = function(kind, data)
      return string.format("|%s|%10.5f|%u|%d|%s|", kind, data["float"],
        data["uint32"],
        data["int32"], numberToBinStr(tonumber(data["uint32"])))
    end,
    [16] = function(kind, data)
      return string.format("|%s|%18.9f|%u|%d|%s|", kind, data["double"],
        data["uint64"],
        data["int64"], numberToBinStr(tonumber(data["uint64"])))
    end
  }

  if #hex_str ~= 4 and #hex_str ~= 8 and #hex_str ~= 16 then
    return nil
  end


  local result = {
    [4] = {
      ab = hex_tonumber(hex_str, "ab"),
      ba = hex_tonumber(hex_str, "ba"),
    },
    [8] = {
      abcd = hex_tonumber(hex_str, "abcd"),
      cdab = hex_tonumber(hex_str, "cdab"),
      badc = hex_tonumber(hex_str, "badc"),
      dcba = hex_tonumber(hex_str, "dcba"),
    },
    [16] = {
      abcdefgh = hex_tonumber(hex_str, "abcdefgh"),
      badcfehg = hex_tonumber(hex_str, "badcfehg"),
      hgfedcba = hex_tonumber(hex_str, "hgfedcba"),
      ghefcdab = hex_tonumber(hex_str, "ghefcdab")
    }
  }

  local lines = {}
  local nm = tonumber(hex_str, 16) or 0
  table.insert(lines, string.format("# %s(%s)", hex_str, numberToBinStr(nm)))
  for _, line in pairs(header[#hex_str]) do
    table.insert(lines, line)
  end

  for kind, data in pairs(result[#hex_str]) do
    table.insert(lines, formater[#hex_str](kind, data.view))
  end

  return lines
end



M.view = function()
  local line1, col1, line2, col2 = visual_selection_range()
  local text = vim.api.nvim_buf_get_text(0, line1 - 1, col1 - 1, line2 - 1, col2, {})
  local hex = string.gsub(text[1], "%s+", "")
  hex = string.gsub(hex, "0x", "")
  hex = string.gsub(hex, ",", "")

  local t = M.hex_view(hex) or {}

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(bufnr, "filetype", "markdown")
  vim.api.nvim_buf_set_keymap(bufnr, "n", 'q', ":close<cr>", { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", '<esc>', ":close<cr>", { noremap = true })
  vim.api.nvim_buf_set_lines(bufnr, 0, 1, true, t)
  vim.api.nvim_open_win(bufnr, true,
    { width = 150, height = 10, relative = 'cursor', row = 5, col = 22, border = "double", })


  if next(t) ~= nil then
    vim.cmd([[TableFormat]])
  end
end


vim.api.nvim_create_user_command("HexView", M.view, { range = 2 })

return M
