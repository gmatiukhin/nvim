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
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

-- Insert --
-- Better navigation
keymap("i", "<A-h>", "<Left>", opts)
keymap("i", "<A-j>", "<Down>", opts)
keymap("i", "<A-k>", "<Up>", opts)
keymap("i", "<A-l>", "<Right>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>h", "<cmd>split<CR>", opts)
keymap("n", "<leader>v", "<cmd>vsplit<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Insert --
-- Press `jj` fast to exit to normal mode
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode when changing indentation of selected text
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
keymap("v", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Make Neovim keep previously yanked value after pasting
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- It looks like remappings from Visual mode also work in Visual Block mode
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
-- keymap("n", "<leader>ff", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<C-t>", ":Telescope live_grep<cr>", opts)

-- Comment
keymap("n", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- Gitsigns
keymap("n", "<C-g>", "<cmd>Gitsigns preview_hunk<CR>", opts)
-- keymap("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", opts)
-- keymap("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", opts)

-- Buffers
keymap("n", "<leader>x", "<cmd>:Bdelete<CR>", opts)

-- vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<cmd>stopinsert | q!<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "i", "<CR>",
--   "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. currName .. "'," .. win .. ")<CR>", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<CR>",
--   "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('" .. currName .. "'," .. win .. ")<CR>", opts)

-- Trouble
keymap("n", "T", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "Z", "<cmd>TroubleToggle todo<CR>", opts)
