return {
	'echasnovski/mini.files',
	version = '*',
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = false,
	config = function()
		local mini_files = require('mini.files')
		local map = require("stable.utils").map
		local vs_map = require("stable.utils").vs_map

		mini_files.setup {}

		-- Keymaps
		vs_map('n', '<Leader>O', '<Cmd>lua MiniFiles.open()<CR>',
			'<Cmd>call VSCodeNotify("workbench.view.explorer")<CR>')

		map('n', '<Leader>o', function()
			MiniFiles.open()
		end)
	end
}
