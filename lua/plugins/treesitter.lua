return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall" },
    keys = {
      { "<CR>", desc = "Increment Selection", noremap = true, silent = true },
      { "<TAB>", desc = "Increment Selection", mode = "x", noremap = true, silent = true },
      { "<BS>", desc = "Decrement Selection", mode = "x", noremap = true, silent = true },
    },
    -- On the main branch, nvim-treesitter only installs parsers.
    -- It does not turn on highlight, indent, or folding by itself.
    init = function()
      -- Add the parser for a language not in the main list.
      -- This runs on the User TSUpdate event, as the docs say to do.
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          local parsers = require("nvim-treesitter.parsers")
          parsers.lhaskell = {
            install_info = {
              url = "https://github.com/gmatiukhin/hacky-tree-sitter-lhaskell",
              branch = "main",
              files = { "src/parser.c" },
            },
            filetype = "lhaskell",
          }
          parsers.kittyconf = {
            install_info = {
              url = "https://github.com/gmatiukhin/tree-sitter-kitty-conf",
              branch = "main",
              files = { "src/parser.c" },
            },
            filetype = "kittyconf",
          }
        end,
      })
    end,
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "markdown_inline",
        "markdown",
        "yaml",
        "regex",
        "latex",
        "rust",
        "cpp",
        "c",
        "python",
        "yuck",
        "bash",
        "fish",
        "commonlisp",
        "haskell",
        "lhaskell",
        "javascript",
        "html",
        "css",
        "hyprlang",
        "wgsl",
        "go",
        "jinja",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install(opts.ensure_installed)

      -- Turn on highlight, indent, and incremental selection per file type.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          local add_ok = pcall(vim.treesitter.language.add, lang)
          if not add_ok then
            return
          end

          -- vim.treesitter.language.add can return true with no real
          -- parser file backing it (e.g. plugin popup filetypes like
          -- "noice"). Guard the actual start call too, or it throws.
          local start_ok = pcall(vim.treesitter.start, args.buf, lang)
          if not start_ok then
            return
          end

          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  -- Show context like function names or loops and conditions
  -- in nested code
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependency = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    opts = {
      enable = true,
      multiwindow = false,
      max_lines = 10,
      min_window_height = 30,
      line_numbers = true,
      multiline_threshold = 10,
      trim_scope = "inner",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  },
  -- Cool rainbow parenthesis
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    ft = { "html" },
    opts = {},
  },
}
