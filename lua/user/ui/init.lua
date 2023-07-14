require("user.ui.colorscheme") -- Important to load first

if IsWorkstation then
  require("user.ui.statusline")
  require("user.ui.winbar")
  require("user.ui.bufferline")
end
