local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  print "Could not find nvim-autopairs"
  return
end

autopairs.setup {
  check_ts = true,
  ts_config = {
    -- lua = { "string" }, -- no autopairs for lua in strings !!! does not work
    -- java = false -- ignore ts in java
  },
  disable_filetype = { "TelescopePrompt" },
  -- if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
  enable_check_bracket_line = true,
  -- if nex char is alphanumeric or `.` don't add closing bracket
  ignored_next_char = "[%w%.]",

  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", "'", '"' },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
}

-- Integration with cmp
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print "Could not find cmp"
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
