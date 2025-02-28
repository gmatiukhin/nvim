return {
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = {
      {
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
        noremap = true,
        silent = true,
      },
      {
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        mode = "v",
        noremap = true,
        silent = true,
      },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  -- Enables shortcuts to comment lines and code blocks
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    keys = {
      {
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
        noremap = true,
        silent = true,
      },
      {
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        mode = "v",
        noremap = true,
        silent = true,
      },
    },
    opts = {
      enable = true,
      enable_autocmd = false,
      languages = {
        lhaskell = "% %s", -- this one is actually TeX
        kittyconf = "# %s",
      },
    },
    config = function(opts)
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup(opts.opts)
    end,
  },
}
