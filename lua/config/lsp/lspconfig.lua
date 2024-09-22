local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {
  on_attach = require("config.lsp.handlers").on_attach,
  capabilities = require("config.lsp.handlers").capabilities,
}

local function configure_servers(servers)
  for _, server in pairs(servers) do
    server = vim.split(server, "@")[1]

    -- Custom settings for some clients
    local require_ok, conf_opts = pcall(require, "config.lsp.settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

local servers = require("config.lsp.servers")
local mason = servers.mason
local external = servers.external

configure_servers(mason)
configure_servers(external)
