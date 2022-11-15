local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("Could not fin Nvim Treesitter")
  return
end

configs.setup({
  ensure_installed = { "lua", "rust", "cpp", "python" },
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
    disable = { "" },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
