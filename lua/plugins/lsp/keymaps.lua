return function(bufnr)
  local keyopts = { noremap = true, silent = true }
  -- Hovers
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", keyopts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", keyopts)

  -- Code actions
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", keyopts)
end
