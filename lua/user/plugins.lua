local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer, close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reload Neovim and syncs packer whenever the `plugins.lua` file is saved
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Place to specify plugins
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Packer manages itself
	use "nvim-lua/plenary.nvim" -- Collecton of common lua functions, used by many plugins
	use "nvim-lua/popup.nvim" -- Implementation of the Popup API from Vim

  use "folke/tokyonight.nvim" -- Tokyonight colorscheme

	-- Automatically set up config aufter cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
