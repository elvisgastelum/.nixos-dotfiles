local utils = require("dev.utils")
local is_neovide = utils.is_neovide
local keybindings = require("dev.keybindings")

return {
	'zbirenbaum/copilot.lua',
	lazy = true,
	config = function()
		require("copilot").setup(keybindings.copilot_config(is_neovide()))
	end
}
