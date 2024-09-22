local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("Could not find lspconfig")
  return
end

require("config.lsp.mason")
require("config.lsp.lspconfig")
require("config.lsp.handlers").setup()
require("config.lsp.diagnostic")
