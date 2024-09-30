return {
	"freddiehaddad/feline.nvim",
	dependencies = {
		"folke/tokyonight.nvim",
	},
	event = "VeryLazy",
	config = function()
		local theme = function()
			local tokyonight = require("tokyonight.colors").setup()
			return {
				fg = tokyonight.fg,
				bg = tokyonight.bg_dark,

				git_add = tokyonight.git.add,
				git_del = tokyonight.git.delete,
				git_mod = tokyonight.git.change,

				error = tokyonight.error,
				warning = tokyonight.warning,
				info = tokyonight.info,
				hint = tokyonight.hint,

				green = tokyonight.green,
				yellow = tokyonight.yellow,
				purple = tokyonight.purple,
				orange = tokyonight.orange,
				peanut = "#f6d5a4",
				red = tokyonight.red,
				blue = tokyonight.blue,
				magenta = tokyonight.magenta,
			}
		end

		local vi_mode_colors = {
			NORMAL = "green",
			OP = "green",
			INSERT = "yellow",
			VISUAL = "purple",
			LINES = "orange",
			BLOCK = "red",
			REPLACE = "magenta",
			COMMAND = "blue",
		}

		local mode_highlight = function()
			return {
				fg = "bg",
				bg = require("feline.providers.vi_mode").get_mode_color(),
			}
		end

		local rev_mode_highlight = function()
			local hl = mode_highlight()
			hl.fg, hl.bg = hl.bg, hl.fg
			return hl
		end

		local vim_mode = {
			provider = {
				name = "vi_mode",
				show_mode_name = true,
				padding = true, -- Uncomment for extra padding.
			},
			icon = "",
			hl = function()
				local hl = mode_highlight()
				hl["style"] = "bold"
				return hl
			end,
			left_sep = "block",
			right_sep = function()
				return {
					str = "slant_right",
					hl = rev_mode_highlight,
				}
			end,
		}

		local fileinfo = {
			provider = {
				name = "file_info",
				type = "relative-short",
			},
			left_sep = "block",
			right_sep = "block",
		}

		local get_git_data = function(info)
			local git_status_ok, git_status = pcall(vim.api.nvim_buf_get_var, 0, "gitsigns_status_dict")
			if not git_status_ok then
				return ""
			end
			local git_info = git_status[info]
			return (git_info ~= nil and git_info ~= 0) and git_info or ""
		end

		local git = {
			branch = {
				provider = function()
					local branch_name = get_git_data("head")
					return (branch_name ~= "") and branch_name or "none"
				end,
				left_sep = {
					str = "slant_right",
					hl = {
						fg = "bg",
						bg = "peanut",
					},
				},
				hl = {
					fg = "bg",
					bg = "peanut",
					style = "bold",
				},
				right_sep = {
					str = "slant_right",
					hl = {
						fg = "peanut",
						bg = "git_add",
					},
				},
				icon = " ",
			},
			diffAdded = {
				provider = function()
					return tostring(get_git_data("added"))
				end,
				hl = {
					fg = "bg",
					bg = "git_add",
				},
				right_sep = {
					str = "slant_right",
					hl = {
						fg = "git_add",
						bg = "git_del",
					},
					always_visible = true,
				},
			},
			diffRemoved = {
				provider = function()
					return tostring(get_git_data("removed"))
				end,
				hl = {
					fg = "bg",
					bg = "git_del",
				},
				right_sep = {
					str = "slant_right",
					hl = {
						fg = "git_del",
						bg = "git_mod",
					},
					always_visible = true,
				},
			},
			diffChanged = {
				provider = function()
					return tostring(get_git_data("changed"))
				end,
				hl = {
					fg = "bg",
					bg = "git_mod",
				},
				right_sep = {
					str = "slant_right",
					hl = {
						fg = "git_mod",
					},
					always_visible = true,
				},
			},
		}

		local get_lsp_diag = function(severity)
			local data = vim.diagnostic.get(0, severity)
			local count = 0
			for _ in pairs(data) do
				count = count + 1
			end
			return (count > 0) and " " .. count .. " " or ""
		end

		local lsp = {
			errors = {
				provider = function()
					return get_lsp_diag({ severity = vim.diagnostic.severity.ERROR })
				end,
				left_sep = { str = "", hl = { fg = "error" }, always_visible = true },
				hl = { fg = "bg", bg = "error" },
				right_sep = { str = "", hl = { fg = "warning", bg = "error" }, always_visible = true },
			},
			warnings = {
				provider = function()
					return get_lsp_diag({ severity = vim.diagnostic.severity.WARN })
				end,
				hl = { fg = "bg", bg = "warning" },
				right_sep = { str = "", hl = { fg = "info", bg = "warning" }, always_visible = true },
			},
			info = {
				provider = function()
					local info = string.gsub(get_lsp_diag({ severity = vim.diagnostic.severity.INFO }), "%s+", "")
					local hint = string.gsub(get_lsp_diag({ severity = vim.diagnostic.severity.HINT }), "%s+", "")
					local sum = (tonumber(info) or 0) + (tonumber(hint) or 0)
					if sum == 0 then
						return ""
					else
						return tostring(sum)
					end
				end,
				hl = { fg = "bg", bg = "info" },
				right_sep = { str = "", hl = { fg = "bg", bg = "info" }, always_visible = true },
			},
			hint = {
				provider = function()
					return get_lsp_diag({ severity = vim.diagnostic.severity.HINT })
				end,
				hl = { fg = "bg", bg = "hint" },
				right_sep = { str = "", hl = { fg = "bg", bg = "hint" }, always_visible = true },
			},
			message = {
				provider = function()
					if not rawget(vim, "lsp") then
						return ""
					end

					local msg = vim.lsp.status()
					-- if not Lsp then
					--   return ""
					-- end
					--
					-- local title = Lsp.title or ""
					-- local msg = Lsp.message or ""
					-- local percentage = Lsp.percentage or 0
					-- local spinners = { "", "" }
					-- local ms = vim.loop.hrtime() / 1000000
					-- local frame = math.floor(ms / 120) % #spinners
					--
					-- local content = ""
					-- if vim.api.nvim_win_get_width(0) < 120 then
					--   content = string.format(" %%<%s", spinners[frame + 1])
					-- else
					--   content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
					-- end

					-- msg = msg:gsub(":", "a")
					-- msg = msg:gsub(" ", "b")
					-- print(msg)
					-- print()
					return ""
				end,
				hl = {
					fg = "info",
				},
			},
		}

		local file_type = {
			provider = function()
				return string.format(" %s ", vim.bo.filetype:upper())
			end,
		}

		local position = {
			position = {
				provider = {
					name = "position",
					format = " {line}:{col} ",
				},
				hl = mode_highlight,
				left_sep = {
					str = "slant_left",
					hl = rev_mode_highlight,
				},
			},
			line_percentage = {
				provider = {
					name = "line_percentage",
					padding = true,
				},
				hl = mode_highlight,
				left_sep = {
					str = "slant_left_thin",
					hl = mode_highlight,
				},
				right_sep = {
					str = "block",
					hl = rev_mode_highlight,
				},
			},
		}

		local left = {
			vim_mode,
			fileinfo,
			git.branch,
			git.diffAdded,
			git.diffRemoved,
			git.diffChanged,
		}

		local middle = {
			lsp.message,
		}

		local right = {
			lsp.errors,
			lsp.warnings,
			lsp.info,
			-- lsp.hint,
			file_type,
			position.position,
			position.line_percentage,
		}

		local components = {
			active = {
				left,
				middle,
				right,
			},
			inactive = {
				{
					fileinfo,
				},
			},
		}

		local feline = require("feline")
		feline.setup({
			components = components,
			vi_mode_colors = vi_mode_colors,
		})
		feline.use_theme(theme())
		-- feline.winbar.setup()
	end,
}
