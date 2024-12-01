local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
keymap("", "q:", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v", visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Insert --
keymap("i", "jk", "<esc>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Beter visual lines navigation
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)

-- Window splitting
-- split line is horizontal, windows stacked on top of each other
keymap("n", "<leader>h", "<cmd>split<CR>", opts)
-- split line is vertical, windows stacked next to each other
keymap("n", "<leader>v", "<cmd>vsplit<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Visual --
-- Stay in indent mode when changing indentation of selected text
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("v", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("v", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Make Neovim keep previously yanked value after pasting
keymap("v", "p", '"_dP', opts)

-- Beter visual lines navigation
keymap("v", "k", "gk", opts)
keymap("v", "j", "gj", opts)

-- Visual Block --
-- Move text up and down
-- It looks like remappings from Visual mode also work in Visual Block mode
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<esc>", "<C-\\><C-n>", term_opts)
keymap("t", "jk", "<C-\\><C-n>", term_opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Gitsigns
keymap("n", "<C-g>", "<cmd>Gitsigns preview_hunk<CR>", opts)
-- keymap("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", opts)
-- keymap("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", opts)

-- vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "i", "<CR>",
--   "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. currName .. "'," .. win .. ")<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<CR>",
--   "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. currName .. "'," .. win .. ")<CR>", opts)
