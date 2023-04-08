local status_ok, feline = pcall(require, "feline")
if not status_ok then
  return
end
-- "┃", "█", "", "", "", "", "", "", "●", ""
-- " "

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

local vim_mode = {
  provider = {
    name = "vi_mode",
    opts = {
      show_mode_name = true,
      -- padding = "center", -- Uncomment for extra padding.
    },
  },
  icon = "",
  hl = function()
    return {
      fg = "darkblue",
      bg = require("feline.providers.vi_mode").get_mode_color(),
      style = "bold",
    }
  end,
  left_sep = "block",
  right_sep = function()
    return {
      str = " ",
      hl = {
        fg = require("feline.providers.vi_mode").get_mode_color(),
        bg = "darkblue",
      },
    }
  end,
}

local fileinfo = {
  provider = {
    name = "file_info",
    opts = {
      type = "relative-short",
    },
  },
  hl = {
    fg = "white",
    bg = "darkblue",
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
      return (branch_name ~= "") and branch_name or "no branch"
    end,
    hl = {
      fg = "darkblue",
      bg = "peanut",
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        fg = "peanut",
        bg = "darkblue",
      },
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "peanut",
        bg = "aqua",
      },
    },
    icon = " ",
  },
  diffAdded = {
    provider = function()
      return tostring(get_git_data("added"))
    end,
    hl = {
      fg = "darkblue",
      bg = "aqua",
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "aqua",
        bg = "red",
      },
      always_visible = true,
    },
  },
  diffRemoved = {
    provider = function()
      return tostring(get_git_data("removed"))
    end,
    hl = {
      fg = "darkblue",
      bg = "red",
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "red",
        bg = "orange",
      },
      always_visible = true,
    },
  },
  diffChanged = {
    provider = function()
      return tostring(get_git_data("changed"))
    end,
    hl = {
      fg = "darkblue",
      bg = "orange",
    },
    right_sep = {
      str = " ",
      hl = {
        fg = "orange",
      },
      always_visible = true,
    },
  },
  -- -- Limits blank space if there are no previous symbols
  -- dummy = {
  --   provider = "",
  -- }
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
    hl = {
      fg = "darkblue",
      bg = "red",
    },
    left_sep = { str = " ", hl = { fg = "red" }, always_visible = true },
    right_sep = { str = " ", hl = { fg = "yellow", bg = "red" }, always_visible = true },
  },
  warnings = {
    provider = function()
      return get_lsp_diag({ severity = vim.diagnostic.severity.WARN })
    end,
    hl = {
      fg = "darkblue",
      bg = "yellow",
    },
    right_sep = { str = " ", hl = { fg = "aqua", bg = "yellow" }, always_visible = true },
  },
  hints = {
    provider = function()
      return get_lsp_diag({ severity = vim.diagnostic.severity.HINT })
    end,
    hl = {
      fg = "darkblue",
      bg = "aqua",
    },
    right_sep = { str = " ", hl = { fg = "orange", bg = "aqua" }, always_visible = true },
  },
  info = {
    provider = function()
      return get_lsp_diag({ severity = vim.diagnostic.severity.INFO })
    end,
    hl = {
      fg = "darkblue",
      bg = "orange",
    },
    right_sep = { str = " ", hl = { fg = "darkblue", bg = "orange" }, always_visible = true },
  },
  message = {
    provider = function()
      if not rawget(vim, "lsp") then
        return ""
      end

      local Lsp = vim.lsp.util.get_progress_messages()[1]
      if not Lsp then
        return ""
      end

      local title = Lsp.title or ""
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local spinners = { "", "" }
      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      local content = ""
      if vim.api.nvim_win_get_width(0) < 120 then
        content = string.format(" %%<%s", spinners[frame + 1])
      else
        content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return content or ""
    end,
    hl = {
      fg = "red",
      -- bg = "darkblue",
    },
  },
}

local file_type = {
  provider = function()
    return string.format("  %s ", vim.bo.filetype:upper())
  end,
  hl = {
    fg = "white",
    bg = "darkblue",
  },
}

local position = {
  position = {
    provider = {
      name = "position",
      opts = {
        format = " {line}:{col} ",
      },
    },
    hl = function()
      return {
        fg = "darkblue",
        bg = require("feline.providers.vi_mode").get_mode_color(),
      }
    end,
    left_sep = {
      str = " ",
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
      str = "",
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
}

local middle = {
  lsp.message,
}

local right = {
  lsp.errors,
  lsp.warnings,
  lsp.hints,
  lsp.info,
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
  inactive = {},
}

feline.setup({
  components = components,
  theme = one_monokai,
  vi_mode_colors = vi_mode_colors,
})
