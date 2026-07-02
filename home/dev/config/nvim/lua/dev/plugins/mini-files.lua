return {
	'echasnovski/mini.files',
	version = '*',
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = false,
	config = function()
		local mini_files = require('mini.files')
		local map = require("dev.utils").map
		local vs_map = require("dev.utils").vs_map
		local keybindings = require("dev.keybindings")

		mini_files.setup {}

		keybindings.apply_mini_files_keymaps(vs_map, map)
	end
}
