local formatters_by_ft = {
	lua = { "stylua" },
	python = { "black" },
	rust = { "yew-fmt", "rustfmt", stop_after_first = true },
	bash = { "shfmt" },
	haskell = { "ormolu" },
	-- cpp = { "clang-format" }
}

-- files formatted by prettier
local prettier = {
	"javascript",
	"html",
	"typescript",
	"css",
	"scss",
	"markdown",
	"yaml",
	"json",
}

for _, v in pairs(prettier) do
	formatters_by_ft[v] = { "prettier", stop_after_first = true }
end

local ft = {}
local n = 0

for k, _ in pairs(formatters_by_ft) do
	n = n + 1
	ft[n] = k
end

return {
	"stevearc/conform.nvim",
	ft = ft,
	opts = {
		formatters_by_ft = formatters_by_ft,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
	setup = function()
		require("conform").formatters.prettier = {
			prepend_args = function(self, ctx)
				return { "--no-color" }
			end,
		}
	end,
	default_format_opts = {
		lsp_format = "fallback",
	},
}
