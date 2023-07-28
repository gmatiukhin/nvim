local formatter_status_ok, formatter = pcall(require, "formatter")
if not formatter_status_ok then
  return
end

local util = require("formatter.util")

formatter.setup({
  logging = false,
  log_level = vim.log.levels.DEBUG,
  filetype = {
    -- Lua_ls already has formatting enabled
    -- lua = { require("formatter.filetypes.lua").stylua },
    rust = { require("formatter.filetypes.rust").rustfmt },
    python = { require("formatter.filetypes.python").black },
    latex = { require("formatter.filetypes.latex").latexindent },
    -- Do not use with if clangd
    -- cpp = { require("formatter.filetypes.cpp").clangformat },
  },
})

vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
  ]],
  true
)
