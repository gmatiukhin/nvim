return {
  "keaising/im-select.nvim",
  event = "VeryLazy",
  opts = {
    default_im_select = "keyboard-us",
    default_command = "fcitx5-remote",
    set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
    set_previous_events = { "InsertEnter" },
    keep_quiet_on_no_binary = false,
    async_switch_im = true,
  },
}
