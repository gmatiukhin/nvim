local conform_status_ok, conform = pcall(require, "conform")
if not conform_status_ok then
  return
end

conform.setup({
  formatter_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt" },
    bash = { "shfmt" },
    yaml = { "yamlfmt" },
    -- cpp = { "clang-format" }
  }
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
