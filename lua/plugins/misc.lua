return {
	{ "nvim-lua/plenary.nvim" },
	{ "akinsho/bufferline.nvim" },
	{
		"mhinz/vim-sayonara",
		keys = {
			{
				"<leader>w",
				"<cmd>:Sayonara!<CR>",
				noremap = true,
				silent = true,
			},
			{
				"<leader>q",
				"<cmd>:Sayonara<CR>",
				noremap = true,
				silent = true,
			},
		},
	},
}
