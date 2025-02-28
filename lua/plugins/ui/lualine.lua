return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "cameronr/lualine-pretty-path",
  },
  event = "VeryLazy",
  opts = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    --- From: https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
    --- @param trunc_width number trunctates component when screen width is less then trunc_width
    --- @param trunc_len number truncates component to trunc_len number of chars
    --- @param hide_width number hides component when window width is smaller then hide_width
    --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
    --- return function that can format the component accordingly
    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.o.columns
        if hide_width and win_width < hide_width then
          return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and "" or "…")
        end
        return str
      end
    end

    -- Override 'encoding': Don't display if encoding is UTF-8.
    local encoding_only_if_not_utf8 = function()
      local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
      return ret
    end
    -- fileformat: Don't display if &ff is unix.
    local fileformat_only_if_not_unix = function()
      local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
      return ret
    end

    return {
      options = {
        theme = function()
          if vim.g.colors_name:match("^tokyonight") then
            return require("lualine.themes." .. vim.g.colors_name)
          end
        end,
        component_separators = { left = "╲", right = "╱" },
        disabled_filetypes = { "NvimTree" },
        section_separators = { left = "", right = "" },
        ignore_focus = { "trouble" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = trunc(130, 3, 0, true),
          },
        },
        lualine_b = {
          {
            "branch",
            fmt = trunc(70, 15, 65, true),
            separator = "",
          },
        },
        lualine_c = {
          {
            "pretty_path",
            directories = {
              shorten = false,
            },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
            fmt = trunc(0, 0, 60, true),
          },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", hint = " ", info = " " },
            separator = "",
          },
          -- Turning off for better days
          -- when i can set cmdheight=0 and not worry about message flicker
          -- {
          -- 	function()
          -- 		return "recording @" .. vim.fn.reg_recording()
          -- 	end,
          -- 	cond = function()
          -- 		return vim.fn.reg_recording() ~= ""
          -- 	end,
          -- 	color = { fg = "#ff007c" },
          -- 	separator = "",
          -- },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            fmt = trunc(0, 0, 160, true), -- hide when window is < 100 columns
            separator = "",
          },

          {
            encoding_only_if_not_utf8,
            fmt = trunc(0, 0, 140, true), -- hide when window is < 80 columns
            separator = "",
          },
          {
            fileformat_only_if_not_unix,
            fmt = trunc(0, 0, 140, true), -- hide when window is < 80 columns
            separator = "",
          },
        },
        lualine_y = {
          { "progress", fmt = trunc(0, 0, 40, true) },
        },
        lualine_z = {
          { "location", fmt = trunc(0, 0, 80, true) },
        },
      },
      extensions = {
        "lazy",
        "mason",
        "trouble",
      },
    }
  end,
}
