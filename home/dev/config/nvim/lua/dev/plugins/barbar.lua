return {
	'romgrk/barbar.nvim',
	dependencies = 'nvim-web-devicons',
	lazy = true,
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		require('dev.keybindings').apply_barbar_keymaps(map, opts)

		-- Other:
		-- :BarbarEnable - enables barbar (enabled by default)
		-- :BarbarDisable - very bad command, should never be used
	end
}
