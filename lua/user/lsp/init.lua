local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print("Could not find lspconfig")
  return
end

require("user.lsp.mason")
require("user.lsp.lspconfig")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
require("user.lsp.diagnostic")
