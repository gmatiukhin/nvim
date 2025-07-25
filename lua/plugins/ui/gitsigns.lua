return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { "F", "<cmd>Gitsigns preview_hunk<CR>", noremap = true, silent = true },
  },
  event = "VeryLazy",
  opts = function()
    -- Disable background highlight for Triangles
    -- local transparent_signs = vim.api.nvim_create_augroup("transparent_signs", { clear = true })
    -- vim.api.nvim_create_autocmd("BufEnter", {
    -- 	pattern = "*",
    -- 	group = transparent_signs,
    -- 	command = "highlight DiffDelete guibg=NONE",
    -- })
    -- vim.api.nvim_create_autocmd("BufEnter", {
    -- 	pattern = "*",
    -- 	group = transparent_signs,
    -- 	command = "highlight DiffChangeDelete guibg=NONE",
    -- })
    return {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "~" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      -- yadm = {
      --   enable = false,
      -- },
    }
  end,
}
