return {
  "windwp/nvim-autopairs",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  event = "VeryLazy",
  opts = {
    check_ts = true,
    ts_config = {
      -- lua = { "string" }, -- no autopairs for lua in strings !!! does not work
      -- java = false -- ignore ts in java
    },
    -- if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
    enable_check_bracket_line = true,
    -- if next character is alphanumeric or `.` don't add closing bracket
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
  },
  setup = function()
    -- Integration with cmp
    require("cmp").event:on(
      "confirm_done",
      require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
    )
  end,
}
