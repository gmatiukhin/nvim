return {
  "lervag/vimtex",
  ft = { "tex", "lhaskell" },
  config = function()
    vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } }
    vim.gvimtex_view_method = "zathura"
  end,
}
