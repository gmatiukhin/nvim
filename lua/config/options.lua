vim.o.fileencoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = false
vim.o.undofile = true
vim.o.smartindent = true
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.updatetime = 300
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false

-- global statusline at the very bottom
vim.o.laststatus = 3
-- setting this to 0 causes the bar to flicker with messages written there
-- can't be bothered to reroute all of them, so this is fine
vim.o.cmdheight = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.g.python3_host_prog = '/usr/bin/python3'
vim.o.whichwrap = vim.o.whichwrap .. "<,>,[,],h,l"

vim.o.winborder = "rounded"
