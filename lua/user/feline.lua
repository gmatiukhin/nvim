local status_ok, feline = pcall(require, "feline")
if not status_ok then
  return
end

local one_monokai = {
	fg = "#abb2bf",
	bg = "#1e2024",
	green = "#98c379",
	yellow = "#e5c07b",
	purple = "#c678dd",
	orange = "#d19a66",
	peanut = "#f6d5a4",
	red = "#e06c75",
	aqua = "#61afef",
	darkblue = "#282c34",
	dark_red = "#f75f5f",
}

local vi_mode_colors = {
	NORMAL = "green",
	OP = "green",
	INSERT = "yellow",
	VISUAL = "purple",
	LINES = "orange",
	BLOCK = "dark_red",
	REPLACE = "red",
	COMMAND = "aqua",
}

local get_diag = function(severity)
    local data = vim.diagnostic.get(0, severity)
    local count = 0
    for _ in pairs(data) do count = count + 1 end
    return (count > 0) and " " .. count .. " " or ""
end

local vim_mode = {
  provider = {
    name = "vi_mode",
    opts = {
      show_mode_name = true,
      -- padding = "center", -- Uncomment for extra padding.
    },
  },
  hl = function()
    return {
      fg = require("feline.providers.vi_mode").get_mode_color(),
      bg = "darkblue",
      style = "bold",
      name = "NeovimModeHLColor",
    }
  end,
  -- left_sep = "block",
  right_sep = "right_filled",
}

local fileinfo = {
  provider = {
    name = "file_info",
    opts = {
      type = "relative-short",
    },
  },
  hl = function()
    return {
      fg = require("feline.providers.vi_mode").get_mode_color(),
      style = "bold",
    }
  end,
  left_sep = " ",
  right_sep = "right_filled",
}

local git = {
  branch = {
    provider = "git_branch",
    hl = {
      fg = "peanut",
    },
    left_sep = "right",
    right_sep = "right_filled",
  },
  diffAdded = {
    provider = "git_diff_added",
    hl = {
      fg = "green",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "right_filled",
  },
  diffRemoved = {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "right_filled",
  },
  diffChanged = {
    provider = "git_diff_changed",
    hl = {
      fg = "fg",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "right_filled",
  },
  -- Limits blank space if there are no previous symbols
  dummy = {
    provider = "",
  }
}

local diagnostic = {
  errors = {
    provider = function()
      return get_diag({ severity = vim.diagnostic.severity.ERROR })
    end,
    hl = {
      fg = "darkblue",
      bg = "red",
    },
    left_sep = { str = "left_filled", hl = { fg = "red" }, always_visible = true },
    right_sep = { str = "left_filled", hl = { fg = "yellow", bg = "red" }, always_visible = true },
  },
  warnings = {
    provider = function()
      return get_diag({ severity = vim.diagnostic.severity.WARN })
    end,
    hl = {
      fg = "darkblue",
      bg = "yellow",
    },
    right_sep = { str = "left_filled", hl = { fg = "aqua", bg = "yellow" }, always_visible = true },
  },
  hints = {
    provider = function()
      return get_diag({ severity = vim.diagnostic.severity.HINT })
    end,
    hl = {
      fg = "darkblue",
      bg = "aqua",
    },
    right_sep = { str = "left_filled", hl = { fg = "orange", bg = "aqua" }, always_visible = true },
  },
  info = {
    provider = function()
      return get_diag({ severity = vim.diagnostic.severity.INFO })
    end,
    hl = {
      fg = "darkblue",
      bg = "orange",
    },
    right_sep = { str = "left_filled", hl = { fg = "darkblue", bg = "orange" }, always_visible = true },
  },
}

local file_type = {
  provider = function()
    return string.format(" %s ", vim.bo.filetype:upper())
  end,
  hl = {
    fg = "white",
    bg = "darkblue",
  },
}

local position = {
  position = {
    provider = function()
      -- TODO: What about 4+ diget line numbers?
      return string.format(" %3d:%-2d ", unpack(vim.api.nvim_win_get_cursor(0)))
    end,
    hl = function()
      return {
        fg = "darkblue",
        bg = require("feline.providers.vi_mode").get_mode_color(),
      }
    end,
    left_sep = {
      str = "left_filled",
      hl = function()
        return {
          fg = require("feline.providers.vi_mode").get_mode_color(),
          bg = "darkblue",
        }
      end,
    },
  },
  line_percentage = {
    provider = function()
      return " " .. require("feline.providers.cursor").line_percentage() .. "  "
    end,
      hl = function()
        return {
          fg = "darkblue",
          bg = require("feline.providers.vi_mode").get_mode_color(),
        }
      end,
    left_sep = {
      str = "left",
      hl = function()
        return {
          fg = "darkblue",
          bg = require("feline.providers.vi_mode").get_mode_color(),
        }
      end,
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
  git.dummy,
}

local right = {
	diagnostic.errors,
	diagnostic.warnings,
	diagnostic.hints,
	diagnostic.info,
  file_type,
	position.position,
	position.line_percentage,
}

local components = {
	active = {
		left,
		right,
	},
	inactive = {
	},
}

feline.setup {
	components = components,
	theme = one_monokai,
	vi_mode_colors = vi_mode_colors,
}

feline.winbar.setup()
