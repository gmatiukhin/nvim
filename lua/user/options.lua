local o = vim.opt

o.fileencoding = "utf-8"
o.number = true
o.relativenumber = true
o.cursorline = false
o.undofile = true
o.smartindent = true
o.clipboard = "unnamedplus"
o.splitright = true
o.splitbelow = true
o.signcolumn = "yes"
o.scrolloff = 8
o.sidescrolloff = 8
o.updatetime = 300
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.termguicolors = true
o.showmode = false
o.backup = false
o.writebackup = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.cmd("let g:python3_host_prog = '/usr/bin/python3'")
vim.cmd("set whichwrap+=<,>,[,],h,l")
