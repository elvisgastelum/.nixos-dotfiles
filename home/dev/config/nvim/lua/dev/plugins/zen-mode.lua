return {
	"folke/zen-mode.nvim",
	config = function ()
		require('zen-mode').setup {}
		local map = require('dev.utils').map
		require('dev.keybindings').apply_zen_mode_keymap(map)
	end
}
