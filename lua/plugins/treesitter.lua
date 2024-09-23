return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		keys = {
			{ "<CR>", desc = "Increment Selection", noremap = true, silent = true },
			{ "<TAB>", desc = "Increment Selection", mode = "x", noremap = true, silent = true },
			{ "<BS>", desc = "Decrement Selection", mode = "x", noremap = true, silent = true },
		},
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"vim",
				"rust",
				"cpp",
				"python",
				"yuck",
				"bash",
				"c",
				"commonlisp",
				"vimdoc",
				"lua",
				"haskell",
				"markdown_inline",
				"markdown",
				"regex",
			},
			sync_installed = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<BS>",
				},
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	-- Show context like function names or loops and conditions
	-- in nested code
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependency = {
			"nvim-tresitter/nvim-treesitter",
		},
		even = "VeryLazy",
		opts = {
			enable = true,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 10,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			zindex = 20,
			on_attach = nil,
		},
	},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		dependency = {
			"nvim-tresitter/nvim-treesitter",
		},
		ft = { "html" },
		opts = {},
	},
}
