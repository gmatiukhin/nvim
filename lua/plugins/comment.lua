return {
	"numToStr/Comment.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	keys = {
		{
			"<leader>/",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
			noremap = true,
			silent = true,
		},
		{
			"<leader>/",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			mode = "v",
			noremap = true,
			silent = true,
		},
	},
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
