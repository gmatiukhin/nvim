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
  use("wbthomason/packer.nvim") -- Packer manages itself
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-tree/nvim-tree.lua")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("numToStr/Comment.nvim")
  use("windwp/nvim-autopairs")

  use("folke/which-key.nvim")
  use("folke/tokyonight.nvim")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- Formatting
  use("mhartington/formatter.nvim")

  -- Diagnostic
  use("folke/trouble.nvim")
  use("folke/todo-comments.nvim")

  -- cmp plugins
  use("hrsh7th/nvim-cmp")         -- The completion plugin
  use("hrsh7th/cmp-buffer")       -- buffer completions
  use("hrsh7th/cmp-path")         -- path completions
  use("hrsh7th/cmp-cmdline")      -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")

  -- snippets
  use("L3MON4D3/LuaSnip")             --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- Telescope
  use("nvim-telescope/telescope.nvim")

  -- toggleterm
  use("akinsho/toggleterm.nvim")

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter")
  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/playground")


  use("lewis6991/gitsigns.nvim")

  use("nvim-tree/nvim-web-devicons")

  -- Tabs, buffers, winbars and statusline
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("feline-nvim/feline.nvim")

  -- LaTeX & Markdown
  use("lervag/vimtex")
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  -- Specific configs
  use("fladson/vim-kitty")
  use("gpanders/nvim-parinfer")
  use("Fymyte/rasi.vim")

  -- Automatically set up config aufter cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
