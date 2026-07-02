return {
	"rafamadriz/neon",
	lazy = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	priority = 1000,
	config = function()
		vim.g.neon_style = "dark"

		vim.g.neon_italic_keyword = true
		vim.g.neon_italic_function = true
		vim.g.neon_italic_comment = true
		vim.g.neon_italic_boolean = true
		vim.g.neon_italic_variable = true

		vim.g.neon_transparent = false
		vim.g.neon_bold = true

		-- vim.cmd [[colorscheme neon]]
	end
}
