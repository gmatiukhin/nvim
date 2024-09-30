return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	event = "VeryLazy",
	opts = {
		notify = {
			view = "mini",
		},
		lsp = {
			enabled = true,
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- Note: noice.nvim doesn't seem to be able to overwrite this one
				-- so it is set manually in the nvim-cmp's config
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				opts = {
					relative = "cursor",
					position = {
						-- Note: By default is 1, which places the border directly on the line,
						-- which covers the element. So move it one line down.
						-- And this seems to be the culprit:
						-- https://github.com/folke/noice.nvim/blob/c1ba80ccf6b3bd8c7fc88fe2e61085131d44ad65/lua/noice/config/views.lua#L137
						row = 2,
					},
				},
			},
			signature = {
				-- Sadly you have to specify this a second time
				opts = {
					relative = "cursor",
					position = {
						row = 2,
					},
				},
			},
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					win_options = {
						winblend = 5,
						-- "Normal" sets the inner background and text color like in a normal window
						-- "SpecialChar" sets background for the border to be the normal background
						-- this helps the hover blend into the window
						winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
					},
					border = {
						style = "rounded",
					},
					relative = "cursor",
					position = {
						row = 1,
					},
				},
			},
		},
		messages = {
			enabled = false,
		},
		presets = {
			inc_rename = true,
			command_palette = true,
			bottom_search = true,
			lsp_doc_border = false,
		},
		routes = {
			-- Hide "File written" message
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			-- Hide "Config Change Detected" message
			{
				filter = {
					find = "Config Change Detected",
				},
				opts = { skip = true },
			},
			-- Show "recording" message
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			-- Hide this warning https://github.com/neovim/neovim/pull/30313#issuecomment-2349327458
			{
				filter = {
					warning = true,
					find = "vim.treesitter.get_parser",
				},
				opts = { skip = true },
			},
			{
				filter = {
					find = "Code actions:",
				},
				opts = { skip = true },
			},
		},
	},
	config = function(_, opts)
		-- HACK: noice shows messages from before it was enabled,
		-- but this is not ideal when Lazy is installing plugins,
		-- so clear the messages in this case.
		if vim.o.filetype == "lazy" then
			vim.cmd([[messages clear]])
		end
		require("noice").setup(opts)
	end,
}
