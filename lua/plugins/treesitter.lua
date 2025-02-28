return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    -- lazy = vim.fn.argc(-1) == 0, -- load early when opening file from cmd
    event = "BufReadPost",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<CR>", desc = "Increment Selection", noremap = true, silent = true },
      { "<TAB>", desc = "Increment Selection", mode = "x", noremap = true, silent = true },
      { "<BS>", desc = "Decrement Selection", mode = "x", noremap = true, silent = true },
    },
    main = "nvim-treesitter.configs",
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
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
      },
      sync_installed = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<BS>",
        },
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.lhaskell = {
        install_info = {
          url = "https://github.com/gmatiukhin/hacky-tree-sitter-lhaskell",
          branch = "main",
          files = { "src/parser.c" },
        },
        filetype = "lhaskell",
      }
      parser_config.kittyconf = {
        install_info = {
          url = "https://github.com/gmatiukhin/tree-sitter-kitty-conf",
          branch = "main",
          files = { "src/parser.c" },
        },
        filetype = "kittyconf",
      }
      require("nvim-treesitter.configs").setup(opts.opts)
    end,
    -- config = function(opts)
    -- 	vim.treesitter.language.register("latex", "lhaskell")
    -- 	local query = vim.treesitter.query.parse(
    -- 		"latex",
    -- 		[[
    -- ;; extends
    --
    -- ((generic_environment
    --   begin: (begin
    --     name: (curly_group_text
    --       text: (text
    --         word: (word) @env.name
    --         (#eq? @env.name "code")
    --         )))
    --   (
    --     (text)
    --     (text)*
    --   ) @injection.content
    --   (#set! injection.language "haskell")
    --   (end))
    --  )
    -- 		 ]]
    -- 	)
    -- 	require("config.util")
    -- 	for _, c in ipairs(query.captures) do
    -- 		vim.notify(vim.inspect(c))
    -- 	end
    -- 	local root = vim.treesitter.get_parser(0, "latex"):parse(true)[1]:root()
    -- 	for pattern, match, metadata in query:iter_matches(root, 0, nil, nil, { all = true }) do
    -- 		-- vim.notify(vim.inspect(pattern))
    -- 		-- for k, v in pairs(match) do
    -- 		-- 	vim.notify(Dump(v))
    -- 		-- end
    -- 		-- vim.notify(vim.inspect({ match[2][1]:range(), { metadata = metadata } }))
    -- 		-- vim.notify(vim.treesitter.get_node_text(match[2][1], 0, { metadata = metadata }))
    --
    -- 		for id, nodes in pairs(match) do
    -- 			local name = query.captures[id]
    -- 			for _, node in ipairs(nodes) do
    -- 				-- vim.notify(Dump(node))
    -- 				local node_data = metadata[id] -- Node level metadata
    -- 				vim.notify(vim.inspect({
    -- 					node = Dump(node),
    -- 					metadata = metadata,
    -- 				}))
    -- 				vim.notify(vim.treesitter.get_node_text(node, 0, { metadata = metadata }))
    -- 			end
    -- 		end
    -- 	end
    -- 	return opts
    -- end,
  },
  -- Show context like function names or loops and conditions
  -- in nested code
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependency = {
      "nvim-tresitter/nvim-treesitter",
    },
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 10,
      trim_scope = "outer",
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
