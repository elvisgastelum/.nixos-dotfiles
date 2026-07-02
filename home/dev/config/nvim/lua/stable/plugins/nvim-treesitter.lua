return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require 'nvim-treesitter'.setup {
			install_dir = vim.fn.stdpath('data') .. '/site', -- directory where tree-sitter stores the compiled parsers.
		}

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
