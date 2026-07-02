local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end


return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{ 'L3MON4D3/LuaSnip' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
	},
	config = function()
		-- And you can configure cmp even more, if you want to.
		local cmp = require('cmp')
		local luasnip = require('luasnip')
		local keybindings = require('dev.keybindings')

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp', max_item_count = 50 },
				{ name = 'luasnip',  max_item_count = 1 },
				{ name = 'path',     max_item_count = 1 },
				{ name = 'buffer',   max_item_count = 3 },
				{ name = 'cmdline',  max_item_count = 5 },
			}),
			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered()
			},
			mapping = keybindings.nvim_cmp_mappings(cmp, luasnip, check_backspace)
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	end
}
