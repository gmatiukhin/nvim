local picker = {
  name = "fzf",
  commands = {
    files = "files",
  },

  open = function(command, opts)
    opts = opts or {}
    if opts.cmd == nil and command == "git_files" and opts.show_untracked then
      opts.cmd = "git ls-files --exclude-standard --cached --others"
    end
    return require("fzf-lua")[command](opts)
  end,
}

local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
}
