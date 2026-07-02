local M = {}

M.organize_imports = function()
	local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = 0 })[1]

	client:exec_cmd(
		{
			title = 'organize_imports',
			command = '_typescript.organizeImports',
			arguments = {
				vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
			}
		},
		{ bufnr = vim.api.nvim_get_current_buf() }
	)
end

return M
