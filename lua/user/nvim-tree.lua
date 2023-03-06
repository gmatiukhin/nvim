local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("Could not find nvim-tree")
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  create_in_closed_folder = false,
  hijack_unnamed_buffer_when_opening = true,
  hijack_cursor = true,
  sync_root_with_cwd = false,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = true,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "v", cb = tree_cb("vsplit") },
        { key = "h", cb = tree_cb("split") },
      },
    },
    number = false,
    relativenumber = false,
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    },
  },
})

-- See https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup for explanation
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- -- create a new, empty buffer
  -- vim.cmd.enew()
  --
  -- -- wipe the directory buffer
  -- vim.cmd.bw(data.buf)

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
