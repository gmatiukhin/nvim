return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  opts = {},
  config = function()
    local leap = require("leap")
    local leap_user = require("leap.user")
    leap.create_default_mappings()
    -- Define equivalence classes for brackets and quotes, in addition to
    -- the default whitespace group:
    leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

    -- Use the traversal keys to repeat the previous motion without
    -- explicitly invoking Leap:
    leap_user.set_repeat_keys("<enter>", "<backspace>")

    -- Define a preview filter (skip the middle of alphanumeric words):
    leap.opts.preview_filter = function(ch0, ch1, ch2)
      return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
    end
  end,
}
