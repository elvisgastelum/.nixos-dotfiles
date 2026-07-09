return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require 'nvim-treesitter'.setup {
			install_dir = vim.fn.stdpath('data') .. '/site', -- directory where tree-sitter stores the compiled parsers.
		}

		vim.api.nvim_create_autocmd('FileType', {
			pattern = {
				'rust',
				'javascript',
				'zig',
				'c',
				'lua',
				'vim',
				'typescript',
				'tsx',
				'lua',
			},
			callback = function()
				-- syntax highlighting, provided by Neovim
				vim.treesitter.start()
				-- folds, provided by Neovim
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'
				-- indentation, provided by nvim-treesitter
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		require 'nvim-treesitter'.install {
			"c",
			"lua",
			"vim",
			"typescript",
			"tsx",
			"javascript",
		}
	end,
}
