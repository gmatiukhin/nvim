if os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil then
  local xkbswitch = require("config.xkbswitch")

  local kbswitch = vim.api.nvim_create_augroup("kbswitch", { clear = true })
  vim.api.nvim_create_autocmd(xkbswitch.events_swtich_to_default, {
    callback = xkbswitch.switch_to_default_kb,
    group = kbswitch,
  })
  vim.api.nvim_create_autocmd(xkbswitch.events_switch_to_previous, {
    callback = xkbswitch.switch_to_previous_kb,
    group = kbswitch,
  })
end

-- https://github.com/fladson/vim-kitty
local kitty_detect = vim.api.nvim_create_augroup("kitty-detect", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  callback = function()
    vim.bo.filetype = "kittyconf"
  end,
  pattern = "kitty.conf,*/kitty/*.conf",
  group = kitty_detect,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  callback = function()
    vim.bo.filetype = "kitty-session"
  end,
  pattern = "*/kitty/*.session",
  group = kitty_detect,
})
