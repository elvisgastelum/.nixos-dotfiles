return {
	"supermaven-inc/supermaven-nvim",
	lazy = false,
	config = function()
		local keybindings = require("dev.keybindings")
		require("supermaven-nvim").setup({
			keymaps = keybindings.keys.supermaven,
		})
	end,
}
