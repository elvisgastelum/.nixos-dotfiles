-- stable utilities
local M = {}
local typescript = require "stable.utils.typescript"
local custom_format = require "stable.utils.format"

M.typescript = typescript
M.custom_format = custom_format

M.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

M.is_vs_code = function()
	return vim.g.vscode
end

M.is_neovide = function()
	return vim.g.neovide
end

M.only_vscode_map = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end

	if M.is_vs_code() then
		vim.keymap.set(mode, lhs, rhs, options)
	end
end


M.vs_map = function(mode, lhs, vim_rhs, vs_code_rhs, opts)
	if M.is_vs_code() and vs_code_rhs then
		M.map(mode, lhs, vs_code_rhs, opts)
	elseif vim_rhs then
		M.map(mode, lhs, vim_rhs, opts)
	end
end

M.create_highlight_cmd = function(hl_group, cterm, ctermbg, guibg)
	local cmd = string.format('highlight %s cterm=%s ctermbg=%s guibg=%s gui=none', hl_group, cterm,
		ctermbg, guibg)
	vim.cmd(cmd)
end



return M
