local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print "Could not fin Nvim Treesitter"
  return
end

configs.setup {
  ensure_installed = { "lua", "rust" },
  sync_installed = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { "" },
  },
}
