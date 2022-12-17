local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reload Neovim and syncs packer whenever the `plugins.lua` file is saved
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Place to specify plugins
return packer.startup(function(use)
  use("folke/which-key.nvim")
  use("wbthomason/packer.nvim") -- Packer manages itself
  use("nvim-lua/plenary.nvim") -- Collecton of common lua functions, used by many plugins
  use("nvim-lua/popup.nvim") -- Implementation of the Popup API from Vim

  use("folke/tokyonight.nvim") -- Tokyonight colorscheme

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- Diagnostic
  use("folke/trouble.nvim")
  use("folke/todo-comments.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- Telescope
  use("nvim-telescope/telescope.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/playground")
  use("numToStr/Comment.nvim")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  use("windwp/nvim-autopairs")

  use("lewis6991/gitsigns.nvim")

  -- Ntim Tree
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")

  -- Tabs, buffers, winbars and statusline
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("feline-nvim/feline.nvim")

  -- LaTeX
  use("lervag/vimtex")

  -- Nix
  use("LnL7/vim-nix")

  -- Automatically set up config aufter cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
