-- Todo: make it work per buffer
M = {
	keyboard = "keychron-keychron-q1v1-keyboard",
	events_swtich_to_default = {
		"InsertLeave",
	},

	events_switch_to_previous = {
		"InsertEnter",
	},
}

local layouts
local layout_names_map = {}
local layout_idx_map = {}
local saved_keymap
local default_layout = "us"

require("config.util")
local get_main_device = function(obj)
	local devices = vim.json.decode(obj.stdout)
	for _, dev in ipairs(devices.keyboards) do
		if dev.name == M.keyboard then
			return dev
		end
	end
end

local map_layout = function(layout)
	return function(obj)
		layout_names_map[obj.stdout:gsub("\r?\n", ""):gsub('"', "")] = layout
	end
end

local prepare_kb_info = function(obj)
	local dev = get_main_device(obj)
	layouts = Explode(",", dev.layout)
	if type(layouts) == "boolean" then
		layouts = { default_layout }
	end
	for i, l in ipairs(layouts) do
		vim.system({
			"bash",
			"-c",
			string.format('xkbcli list  | yq "[.layouts.[] | select(.layout == \\"%s\\")][0].description"', l),
		}, { text = true }, map_layout(l))
		layout_idx_map[l] = i - 1
	end
end

local save_keymap = function(obj)
	local dev = get_main_device(obj)
	saved_keymap = layout_names_map[dev.active_keymap]
end

vim.system({ "hyprctl", "devices", "-j" }, { text = true }, prepare_kb_info)

M.switch_to_default_kb = function()
	local function switch(obj)
		save_keymap(obj)
		vim.system({ "hyprctl", "switchxkblayout", M.keyboard, layout_idx_map[default_layout] }, { text = true })
	end
	vim.system({ "hyprctl", "devices", "-j" }, { text = true }, switch)
end

M.switch_to_previous_kb = function()
	vim.system({ "hyprctl", "switchxkblayout", M.keyboard, layout_idx_map[saved_keymap] }, { text = true })
end

return M
