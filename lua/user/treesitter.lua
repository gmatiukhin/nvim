local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("Could not find Nvim Treesitter")
  return
end

ts_configs.setup({
  ensure_installed = { "vim", "rust", "cpp", "python", "yuck", "bash", "c", "commonlisp", "vimdoc", "lua" },
  sync_installed = true,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
})

local status_ok, context_commentstring = pcall(require, "ts_context_commentstring")
if not status_ok then
  print("Could not find Treesitter context commentstring")
  return
end

context_commentstring.setup({
  enable = true,
  enable_autocmd = false,
})

vim.g.skip_ts_context_commentstring_module = true

local status_ok, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not status_ok then
  print("Could not find rainbow delimiters for Treesitter")
  return
end

require("rainbow-delimiters.setup").setup({
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
  },
  query = {
    [''] = 'rainbow-delimiters',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
})
