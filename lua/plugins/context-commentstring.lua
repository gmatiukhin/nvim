return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		enable = true,
		enable_autocmd = false,
	},
	config = function()
		vim.g.skip_ts_context_commentstring_module = true
	end,
}
