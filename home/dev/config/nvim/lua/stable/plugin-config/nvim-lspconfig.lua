M = {}

M.setup = function()
	require 'mason'.setup {}
end

M.lazy_setup = {
	'neovim/nvim-lspconfig',
	cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'williamboman/mason-lspconfig.nvim' },
	},
	config = function()
		-- This is where all the LSP shenanigans will live
		local lspconfig = require('lspconfig')
		local cmp_nvim_lsp = require('cmp_nvim_lsp')
		local utils = require('stable.utils')
		local map = utils.map
		local vs_map = utils.vs_map
		local create_highlight_cmd = utils.create_highlight_cmd

		local capabilities = cmp_nvim_lsp.default_capabilities()


		local on_attach = function(client, bufnr)
			-------- LSP keybindings --------

			-- Lsp diagnostics
			map('n', 'dn', function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { silent = true })
			map('n', 'dp', function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { silent = true })
			map('n', 'do', function()
				vim.diagnostic.open_float()
			end, { silent = true })
			map('n', 'df', '<Cmd>lua vim.lsp.buf.code_action()<CR>',
				{ noremap = true, silent = true })

			-- Open autocomplete in insert mode with LSP
			map('i', '<C-Space>', vim.lsp.buf.completion)

			-- Search symbols with Telescope
			-- map('n', '<Leader>gr', "<Cmd>Telescope lsp_document_symbols<CR>",
			-- 	{ noremap = true, silent = true })

			-- Go to definition
			-- map('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
			vs_map('n', 'gd', Snacks.picker.lsp_definitions,
				'<Cmd>call VSCodeNotify("editor.action.goToDefinition")<CR>',
				{ noremap = true, silent = true })

			-- Go to definition in split view
			map('n', 'gD', '<Cmd>tab split | lua require("telescope.builtin").lsp_definitions()<CR>',
				{ noremap = true, silent = true })

			-- Go to definition in vertical split view
			vs_map('n', 'gs', 'mmH<Cmd>vs<CR><C-w>l`m<Cmd>lua Snacks.picker.lsp_definitions()<CR>',
				"<Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>",
				{ noremap = true, silent = true })

			-- Go to definition in horizontal split view
			map('n', 'gh', 'mmH<Cmd>sp<CR><C-w>j`m<Cmd>lua vim.lsp.buf.definition()<CR>',
				{ noremap = true, silent = true })

			-- Show hover information
			map('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })

			-- Show references
			vs_map('n', 'gr', '<Cmd>lua Snacks.picker.lsp_references()<CR>',
				'<Cmd>call VSCodeNotify("editor.action.referenceSearch.trigger")<CR>',
				{ noremap = true, silent = true })

			-- Rename using inc-rename.nvim
			vs_map("n", "rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, '<Cmd>call VSCodeNotify("editor.action.rename")<CR>', { expr = true })

			if client.name == "prismals" then
				client.server_capabilities.documentFormattingProvider = false
			end

			-- Server capabilities spec:
			-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
			if client.server_capabilities.documentHighlightProvider then
				vim.opt.updatetime = 300
				vim.opt.cursorline = true
				vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
				vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }

				create_highlight_cmd("LspReferenceText", "bold", "237", "#5B5653")
				create_highlight_cmd("LspReferenceRead", "bold", "237", "#5B5653")
				create_highlight_cmd("LspReferenceWrite", "bold", "237", "#5B5653")
				create_highlight_cmd("CursorLine", "bold", "237", "#3B3939")

				vim.api.nvim_create_autocmd("CursorHold", {
					callback = vim.lsp.buf.document_highlight,
					buffer = bufnr,
					group = "lsp_document_highlight",
					desc = "Document Highlight",
				})
				vim.api.nvim_create_autocmd("CursorMoved", {
					callback = vim.lsp.buf.clear_references,
					buffer = bufnr,
					group = "lsp_document_highlight",
					desc = "Clear All the References",
				})
			end
		end

		require('mason-lspconfig').setup({
			ensure_installed = {
				'bashls',
				'cssls',
				'dockerls',
				'graphql',
				'html',
				'jsonls',
				'ts_ls',
				'eslint',
				'tailwindcss',
				'tailwindcss',
				'vimls',
				'lua_ls',
				'yamlls',
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup {
						on_attach = on_attach,
						capabilities = capabilities,
					}
				end,
				denols = function()
					lspconfig.denols.setup {
						on_attach = on_attach,
						capabilities = capabilities,
						root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
					}
				end,
				ts_ls = function()
					lspconfig.ts_ls.setup {
						on_attach = function(client, bufnr)
							on_attach(client, bufnr)

							if require("lspconfig").util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
								client.stop()
							end
						end,
						root_dir = lspconfig.util.root_pattern("tsconfig.base.json", "nx.json", "tsconfig.json", "jsconfig.json", "package.json"),
						single_file_support = false,
						capabilities = capabilities,
						settings = {
							documentFormatting = false,
						},
					}
				end,
				prismals = function()
					lspconfig.prismals.setup {
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							documentFormatting = false,
						},
					}
				end,
				eslint = function()
					lspconfig.eslint.setup {
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							documentFormatting = false,
						},
					}
				end,
				tailwindcss = function()
					lspconfig.tailwindcss.setup {
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							documentFormatting = false,
						},
					}
				end,
				lua_ls = function()
					lspconfig.lua_ls.setup {
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" }
								}
							}
						}
					}
				end,
			}
		})

		vim.lsp.handlers['textDocument/signatureHelp'] = function(err, result, ctx, config)
			config = vim.tbl_deep_extend('force', config or {}, { border = 'rounded' })
			return vim.lsp.handlers.signature_help(err, result, ctx, config)
		end

		vim.diagnostic.config {
			underline = false,
			virtual_text = true,
			float = { border = "rounded" },
		}
	end
}

return M
