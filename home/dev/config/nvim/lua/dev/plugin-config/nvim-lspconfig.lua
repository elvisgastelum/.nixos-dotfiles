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
		local utils = require('dev.utils')
		local keybindings = require('dev.keybindings')
		local create_highlight_cmd = utils.create_highlight_cmd

		local capabilities = cmp_nvim_lsp.default_capabilities()


		local on_attach = function(client, bufnr)
			keybindings.apply_lsp_on_attach(utils)

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

		lspconfig.nixd.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				nixd = {
					nixpkgs = {
						expr = 'import (builtins.getFlake "/home/dev/.nixos-dotfiles").inputs.nixpkgs { system = "x86_64-linux"; }',
					},
					formatting = {
						command = { 'nixfmt' },
					},
					options = {
						nixos = {
							expr = '(builtins.getFlake "/home/dev/.nixos-dotfiles").nixosConfigurations.desktop-rtx.options',
						},
						home_manager = {
							expr = '(builtins.getFlake "/home/dev/.nixos-dotfiles").nixosConfigurations.desktop-rtx.options.home-manager.users.type.getSubOptions []',
						},
					},
				},
			},
		}

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
						root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
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
