local formatter_status_ok, formatter = pcall(require, "formatter")
if not formatter_status_ok then
  return
end

formatter.setup {
  logging = false,
  log_level = vim.log.levels.DEBUG,
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
          },
          stdin = true,
        }
      end
    },
    rust = { require("formatter.filetypes.rust").rustfmt },
    python = { require("formatter.filetypes.python").black },
    latex = { require("formatter.filetypes.latex").latexindent },
    cpp = { require("formatter.filetypes.cpp").clangformat },

    -- Any filetype
    ["*"] = {
      require("formatter.defaults").prettier,
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
  ]],
  false
)
