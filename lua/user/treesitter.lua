local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("Could not fin Nvim Treesitter")
  return
end

configs.setup({
  ensure_installed = { "vim", "rust", "cpp", "python" },
  sync_installed = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
})

local context_commentstring = require("ts_context_commentstring")
context_commentstring.setup({
  enable = true,
  enable_autocmd = false,
})

vim.g.skip_ts_context_commentstring_module = true
