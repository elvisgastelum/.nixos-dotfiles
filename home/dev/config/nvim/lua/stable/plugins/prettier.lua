return {
	'MunifTanjim/prettier.nvim',
	dependencies = {
		{ 'neovim/nvim-lspconfig' },
		{ 'jose-elias-alvarez/null-ls.nvim' }
	},
	config = function()
		local prettier = require("prettier")

		prettier.setup({
			bin = 'prettier', -- or `'prettierd'` (v0.22+)
			filetypes = {
				"css",
				"graphql",
				"prisma",
				"html",
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"json",
				"less",
				"markdown",
				"scss",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
				"yaml",
				"lua"
			},
			cli_options = {
				-- https://prettier.io/docs/en/cli.html#--config-precedence
				config_precedence = "prefer-file", -- or "cli-override" or "file-override"
			},
		})
	end
}
