return {
	"Equilibris/nx.nvim",

	dependencies = {
		"nvim-telescope/telescope.nvim",
	},

	opts         = {
		-- See below for config options
		nx_cmd_root = "npx nx",
	},

	-- Plugin will load when you use these keys
	keys = {
		{ require("dev.keybindings").keys.nx.actions, "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
	},
}
