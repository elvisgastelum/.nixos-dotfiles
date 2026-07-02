local vs_map = require("stable.utils").vs_map

local M = {}

M.setup = function(_)
	local vscode = require("vscode")
	local only_vscode_map = require("stable.utils").only_vscode_map
	-- Set clipboard provider to VSCode
	vim.g.clipboard = vim.g.vscode_clipboard

	-- Move lines with Opt+ jk
	only_vscode_map("v", "<2206>", ":m '>+1<CR>gv=gv")
	only_vscode_map("v", "<A-k>", ":m '<-2<CR>gv=gv")

	-- Multi cursor
	only_vscode_map({ "n", "x", "i" }, "<C-d>", function()
			vscode.with_insert(function()
				vscode.action("editor.action.addSelectionToNextFindMatch")
			end)
		end,
		{ noremap = true, silent = true })

	-- Go to definition
	-- MOVED: nvim-lspconfig.lua
	-- vs_map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',
	-- 	"<Cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>",
	-- 	{ noremap = true, silent = true })

	-- Go to definition aside
	-- MOVED: nvim-lspconfig.lua
	-- vs_map('n', 'gs', 'mmH<Cmd>vs<CR><C-w>l`m<Cmd>lua Snacks.picker.lsp_definitions()<CR>',
	-- 	"<Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>",
	-- 	{ noremap = true, silent = true })

	-- Show references
	-- MOVED: nvim-lspconfig.lua
	-- vs_map('n', 'gr', require("telescope.builtin").lsp_references,
	-- 	'<Cmd>lua require("vscode").call("editor.action.referenceSearch.trigger")<CR>',
	-- 	{ noremap = true, silent = true })

	-- Rename using inc-rename.nvim
	vs_map("n", "rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, '<Cmd>lua require("vscode").call("editor.action.rename")<CR>', { noremap = true, silent = true })

	-- Zen mode toggle
	vs_map('n', 'mz', '<Cmd>ZenMode<CR>', '<Cmd>lua require("vscode").call("workbench.action.toggleZenMode")<CR>',
		{ noremap = true, silent = true })

	-- Quickfix toggle
	vs_map('n', 'df', '<Cmd>lua vim.lsp.buf.code_action()<CR>',
		'<Cmd>lua require("vscode").call("editor.action.quickFix")<CR>',
		{ noremap = true, silent = true })

	-- Go to next diagnostic
	vs_map('n', 'dn', function()
		vim.diagnostic.jump({ count = 1, float = true })
	end,
		'<Cmd>lua require("vscode").call("editor.action.marker.next")<CR>',
		{ noremap = true, silent = true })

	-- Go to previous diagnostic
	vs_map('n', 'dp', function()
		vim.diagnostic.jump({ count = -1, float = true })
	end,
		'<Cmd>lua require("vscode").call("editor.action.marker.prev")<CR>',
		{ noremap = true, silent = true })
	-- Go to symbol
	-- vs_map('n', '<Leader>gr', '<Cmd>Telescope lsp_document_symbols<CR>',
	-- 	'<Cmd>lua require("vscode").call("workbench.action.gotoSymbol")<CR>',
	-- 	{ noremap = true, silent = true })
end

return M
