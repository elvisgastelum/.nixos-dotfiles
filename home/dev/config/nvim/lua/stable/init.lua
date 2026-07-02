local M = {}

function M.setup()
	require('stable.keymaps')
	require('stable.options')

	require('stable.lazy')

	local is_vs_code = require("stable.utils").is_vs_code

	if is_vs_code() then
		require("stable.vs-code").setup {}
	end
end

return M
