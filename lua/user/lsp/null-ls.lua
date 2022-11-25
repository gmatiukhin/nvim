local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  debug = false,
  sources = {
    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.black.with({ extra_args = { "--fast" } }),
    formatting.stylua.with({
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
    formatting.rustfmt.with({
      extra_args = { "--edition=2021" },
    }),
    -- diagnostics.flake8.with({
    --   "--max-line-length",
    --   "160",
    -- }),
    formatting.black,
    formatting.latexindent,
    -- formatting.clang_format, -- if clangd is installed this will cause errors
  },
})
