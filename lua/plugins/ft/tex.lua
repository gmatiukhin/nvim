return {
  "lervag/vimtex",
  ft = "tex",
  config = function ()
    vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } }
  end,
}
