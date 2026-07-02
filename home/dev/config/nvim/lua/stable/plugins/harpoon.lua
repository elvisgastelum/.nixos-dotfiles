return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
	},
	config = function()
		local harpoon = require("harpoon")
		local utils = require "stable.utils"
		local map = utils.map

		harpoon:setup {
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		}
		-- REQUIRED
		map("n", "<A-a>", function() harpoon:list():append() end)
		map("n", "<A-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		map("n", "<A-u>", function() harpoon:list():select(1) end)
		map("n", "<A-i>", function() harpoon:list():select(2) end)
		map("n", "<A-o>", function() harpoon:list():select(3) end)
		map("n", "<A-p>", function() harpoon:list():select(4) end)
	end,
}
