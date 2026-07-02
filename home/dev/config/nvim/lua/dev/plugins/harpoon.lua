return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
	},
	config = function()
		local harpoon = require("harpoon")
		local utils = require "dev.utils"
		local map = utils.map
		local keybindings = require "dev.keybindings"

		harpoon:setup {
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		}
		keybindings.apply_harpoon_keymaps(map, harpoon)
	end,
}
