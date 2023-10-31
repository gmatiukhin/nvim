local function getHostname()
  local f = io.popen("/bin/hostname")
  local hostname = f:read("*a") or ""
  f:close()
  hostname = string.gsub(hostname, "\n$", "")
  return hostname
end

local function contains(tab, el)
  for _, v in pairs(tab) do
    if v == el then return true end
  end
end

local workstations = { "Mercury", "Ganymede" }

IsWorkstation = false
if contains(workstations, getHostname()) ~= nil then
  IsWorkstation = true
end

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.completion")
require("user.nvim-tree")
require("user.ui")
require("user.autopairs")
require("user.comment")

if IsWorkstation then
  require("user.lsp")
  require("user.telescope")
  require("user.treesitter")
  require("user.gitsigns")
  require("user.toggleterm")
  require("user.formatter")
  require("user.vimtex")
end
