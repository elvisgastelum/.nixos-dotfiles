local M = {}

function M.setup()
	require('dev.keymaps')
	require('dev.options')

	require('dev.lazy')

	local is_vs_code = require("dev.utils").is_vs_code

	if is_vs_code() then
		require("dev.vs-code").setup {}
	end
end

return M
