local vs_map = require("dev.utils").vs_map
local keybindings = require("dev.keybindings")

local M = {}

M.setup = function(_)
	local vscode = require("vscode")
	local only_vscode_map = require("dev.utils").only_vscode_map
	vim.g.clipboard = vim.g.vscode_clipboard

	keybindings.apply_vscode_keymaps(vs_map, only_vscode_map, vscode)
end

return M
