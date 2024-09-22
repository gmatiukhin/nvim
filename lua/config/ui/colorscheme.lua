vim.cmd([[
  try
    colorscheme tokyonight-night
  catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme habamax
  endtry
]])
