local formatters_by_ft = {
	lua = { "stylua" },
	python = { "black" },
	rust = { "yew-fmt", "rustfmt", stop_after_first = true },
	bash = { "shfmt" },
	yaml = { "yamlfmt" },
	haskell = { "ormolu" },
	-- cpp = { "clang-format" }
}

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
}
