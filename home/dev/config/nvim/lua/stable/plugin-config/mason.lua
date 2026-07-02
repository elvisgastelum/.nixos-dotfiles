M = {}

M.setup = function()
	require 'mason'.setup {}
end

M.lazy_setup = {
	'williamboman/mason.nvim',
	config = M.setup,
}

return M
