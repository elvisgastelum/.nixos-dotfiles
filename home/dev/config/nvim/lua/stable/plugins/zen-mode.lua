return {
	"folke/zen-mode.nvim",
	config = function ()
		require('zen-mode').setup {}
		local map = require('stable.utils').map

		map('n', '<A-z>', '<Cmd>ZenMode<CR>')
	end
}
