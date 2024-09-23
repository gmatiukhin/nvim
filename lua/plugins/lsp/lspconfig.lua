return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	lazy = false,
	config = function()
		local lspconfig = require("lspconfig")
		local handlers = require("plugins.lsp.handlers")
		local servers = require("plugins.lsp.servers")

		for _, server in pairs(servers) do
			local opts = {
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
			}

			-- Custom settings for some clients
			local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
			if require_ok then
				opts = vim.tbl_deep_extend("force", conf_opts, opts)
			end

			lspconfig[server].setup(opts)
			handlers.setup()
		end
	end,
}
