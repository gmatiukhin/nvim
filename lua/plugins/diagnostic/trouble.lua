return {
	"folke/trouble.nvim",
	keys = {
		{ "gr", "<cmd>Trouble lsp_references focus<cr>", noremap = true, silent = true },
		{ "gd", "<cmd>Trouble lsp_definitions<cr>", noremap = true, silent = true },
		{ "gD", "<cmd>Trouble lsp_declarations<cr>", noremap = true, silent = true },
		{ "gi", "<cmd>Trouble lsp_implementations focus<cr>", noremap = true, silent = true },
		{ "tt", "<cmd>Trouble todo toggle<cr>", noremap = true, silent = true },
		{ "td", "<cmd>Trouble diagnostics toggle<cr>", noremap = true, silent = true },
	},
	dependencies = {
		"folke/todo-comments.nvim",
	},
	opts = {
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 10, -- height of the trouble list when position is top or bottom
		width = 50, -- width of the list when position is left or right
		mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		fold_open = "", -- icon used for open folds
		fold_closed = "", -- icon used for closed folds
		group = true, -- group results by file
		padding = true, -- add an extra new line on top of the list
		action_keys = {
			-- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example:
			-- close = {},
			close = "q", -- close the list
			cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = { "o" }, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small popup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = { "zM", "zm" }, -- close all folds
			open_folds = { "zR", "zr" }, -- open all folds
			toggle_fold = { "zA", "za" }, -- toggle fold of current file
			previous = "k", -- previous item
			next = "j", -- next item
		},
		indent_lines = true, -- add an indent guide below the fold icons
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = true, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
		auto_fold = false, -- automatically fold a file trouble list at creation
		warn_no_results = false,
		focus = true,
		auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
		signs = {
			-- icons / text used for a diagnostic
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "",
		},
		use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
	},
}
