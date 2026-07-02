return {
	"baliestri/aura-theme",
	lazy = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	priority = 1000,
	config = function(plugin)
		vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
		-- vim.cmd([[colorscheme aura-dark]])
	end
}
