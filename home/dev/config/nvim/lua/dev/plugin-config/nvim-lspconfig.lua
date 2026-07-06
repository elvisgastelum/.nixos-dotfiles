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
		local cmp_nvim_lsp = require('cmp_nvim_lsp')
		local utils = require('dev.utils')
		local keybindings = require('dev.keybindings')
		local create_highlight_cmd = utils.create_highlight_cmd

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local function configure_server(server_name, config)
			vim.lsp.config(server_name, config)
			vim.lsp.enable(server_name)
		end


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

		configure_server('nixd', {
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
		})

		configure_server('bashls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('cssls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('dockerls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('graphql', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('html', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('jsonls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('vimls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		configure_server('yamlls', {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		require('mason-lspconfig').setup({
			automatic_enable = false,
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
				'vimls',
				'lua_ls',
				'yamlls',
			},
		})

		configure_server('denols', {
			on_attach = on_attach,
			capabilities = capabilities,
			root_markers = { 'deno.json', 'deno.jsonc' },
		})

		configure_server('ts_ls', {
			on_attach = function(client, bufnr)
				if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) then
					client.stop()
					return
				end

				on_attach(client, bufnr)
			end,
			root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})

		configure_server('prismals', {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})

		configure_server('eslint', {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})

		configure_server('tailwindcss', {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				documentFormatting = false,
			},
		})

		configure_server('lua_ls', {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
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
