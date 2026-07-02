return {
	"supermaven-inc/supermaven-nvim",
	lazy = false,
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<A-p>",
				accept_word = "<A-w>",
				clear_suggestion = "<A-c>",
			}
		})
	end,
}
