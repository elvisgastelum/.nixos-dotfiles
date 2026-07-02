local utils = require("stable.utils")
local is_neovide = utils.is_neovide

return {
	'zbirenbaum/copilot.lua',
	lazy = true,
	config = function()
		if is_neovide() then
			require("copilot").setup({
				panel = {
					auto_refresh = false,
					keymap = {
						accept = "<CR>",
						jump_prev = "[[",
						jump_next = "]]",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<D-CR>",
						prev = "<D-[>",
						next = "<D-]>",
						dismiss = "<C-]>",
					},
				},
			})
		else
			require("copilot").setup({
				panel = {
					auto_refresh = false,
					keymap = {
						accept = "<CR>",
						jump_prev = "[[",
						jump_next = "]]",
						refresh = "gr",
						open = "<D-CR>",
					},
				},
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<A-CR>",
						prev = "[[",
						next = "]]",
						dismiss = "}}",
					},
				},
			})
		end
	end
}
