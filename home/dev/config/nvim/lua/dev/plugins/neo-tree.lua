return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	enabled = false,
	config = function()
		local keybindings = require("dev.keybindings")
		require("neo-tree").setup({
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			default_component_configs = {
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon"
				},

			},
			window = {
				position = "float",
				width = 35,
			},
			filesystem = {
				use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
				hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
				window = {
					mappings = keybindings.neo_tree_mappings(),
				}
			},
		})
	end
}
