return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"smjonas/inc-rename.nvim",
			keys = {
				{ "<leader>rn", ":IncRename ", noremap = true, silent = true },
			},
			opts = {},
		},
		"hrsh7th/nvim-cmp",
	},
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			inc_rename = true,
			command_palette = true,
		},
		cmdline = {
			view = "cmdline",
		},
	},
}
