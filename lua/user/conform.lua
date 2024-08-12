local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    rust = { "yew-fmt", "rustfmt", stop_after_first = true },
    bash = { "shfmt" },
    yaml = { "yamlfmt" },
    haskell = { "ormolu" },
    -- cpp = { "clang-format" }
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })
