local M = {}

M.leader = " "

M.keys = {
	core = {
		visual_move_down = "<A-j>",
		visual_move_up = "<A-k>",
		insert_escape = "jj",
		insert_delete_line = "<D-BS>",
		insert_delete_word = "<M-BS>",
		normal_move_down = "<A-j>",
		normal_move_up = "<A-k>",
		open_vsplit = "<C-v>",
		open_split = "<C-s>",
		split_to_horizontal = "<Leader>clh",
		split_to_vertical = "<Leader>clv",
		navigate_left = "<C-h>",
		navigate_down = "<C-j>",
		navigate_up = "<C-k>",
		navigate_right = "<C-l>",
		save = "<Leader>s",
		quit = "<Leader>q",
		force_quit = "<C-q>",
		force_quit_all = "<C-S-q>",
		save_and_quit = "<Leader>wq",
		save_file = "<Leader>ww",
		save_all = "<Leader>wa",
		resize_inc = "<M-=>",
		resize_dec = "<M-->",
		equalize = "<M-+>",
		resize_more = "<Leader>=",
		resize_less = "<Leader>-",
		terminal_escape = "<Esc>",
		new_tab = "tN",
		next_tab = "tn",
		prev_tab = "tp",
		close_tab = "xx",
		format = "fo",
		organize_imports = "so",
		split_editor = "sp",
		vsplit_editor = "hp",
		code_action = "<Leader>a",
		hop_char = "<Leader>j",
		find_files = "<Leader>ff",
		buffer_fuzzy = "<Leader>/",
		telescope_buffers = "<Leader>fb",
		telescope_help = "<Leader>fh",
		telescope_commits = "<Leader>fc",
		telescope_options = "<Leader>fo",
		telescope_keymaps = "<Leader>fk",
		telescope_projects = "<Leader>fp",
		telescope_quickfix = "<Leader>fq",
		telescope_diagnostics = "<Leader>fd",
		diagnostic_next = "dn",
		diagnostic_prev = "dp",
		diagnostic_float = "do",
		oil_parent = "-",
		oil_cwd = "_",
	},
	vscode = {
		visual_move_down = "<2206>",
		visual_move_up = "<A-k>",
		multi_cursor = "<C-d>",
		rename = "rn",
		zen_mode = "mz",
		quickfix = "df",
		diagnostic_next = "dn",
		diagnostic_prev = "dp",
	},
	lsp = {
		code_action = "df",
		completion = "<C-Space>",
		definition = "gd",
		definition_tab = "gD",
		definition_vsplit = "gs",
		definition_split = "gh",
		hover = "K",
		references = "gr",
		rename = "rn",
	},
	snacks_toggles = {
		spell = "<leader>us",
		wrap = "<leader>uw",
		relativenumber = "<leader>uL",
		diagnostics = "<leader>ud",
		line_numbers = "<leader>ul",
		conceallevel = "<leader>uc",
		treesitter = "<leader>uT",
		background = "<leader>ub",
		inlay_hints = "<leader>uh",
		indent = "<leader>ug",
		dim = "<leader>uD",
	},
	oil = {
		help = "g?",
		select = "<CR>",
		vsplit = "<C-s>",
		split = "<C-h>",
		tab = "<C-t>",
		preview = "<C-p>",
		close = "<C-c>",
		refresh = "<C-l>",
		parent = "-",
		open_cwd = "_",
		cd = "`",
		tcd = "~",
		sort = "gs",
		external = "gx",
		hidden = "g.",
		trash = "g\\",
		save_buffer = "<Leader>ww",
		close_buffer = "<Leader>q",
		discard_changes = "Q",
		open_float = "<Leader>O",
		open = "<Leader>o",
	},
	barbar = {
		prev = "<A-,>",
		next = "<A-.>",
		next_tab = "<C-Tab>",
		prev_tab = "<C-S-Tab>",
		move_prev = "<A-<>",
		move_next = "<A->>",
		goto_1 = "<A-1>",
		goto_2 = "<A-2>",
		goto_3 = "<A-3>",
		goto_4 = "<A-4>",
		goto_5 = "<A-5>",
		goto_6 = "<A-6>",
		goto_7 = "<A-7>",
		goto_8 = "<A-8>",
		goto_9 = "<A-9>",
		goto_last = "<A-0>",
		pin = "<A-p>",
		close = "<A-c>",
		pick = "<C-p>",
		order_buffer = "<Space>bb",
		order_directory = "<Space>bd",
		order_language = "<Space>bl",
		order_window = "<Space>bw",
	},
	harpoon = {
		append = "<A-a>",
		menu = "<A-e>",
		select_1 = "<A-u>",
		select_2 = "<A-i>",
		select_3 = "<A-o>",
		select_4 = "<A-p>",
	},
	zen_mode = {
		toggle = "<A-z>",
	},
	nx = {
		actions = "<leader>nx",
	},
	none_ls = {
		format = "<Leader>fo",
		range_format = "<Leader>f",
	},
	supermaven = {
		accept_suggestion = "<A-p>",
		accept_word = "<A-w>",
		clear_suggestion = "<A-c>",
	},
	cmp = {
		complete = "<C-Space>",
		scroll_up = "<C-u>",
		scroll_down = "<C-d>",
		confirm_select = "<C-y>",
		confirm = "<CR>",
		next = "<Tab>",
		prev = "<S-Tab>",
	},
	telescope = {
		send_to_qflist = "<c-q>",
		preview_up = "<c-b>",
		preview_down = "<c-f>",
		disable_insert_down = "<c-j>",
		open_diffview = "<M-d>",
	},
	copilot = {
		panel = {
			accept = "<CR>",
			jump_prev = "[[",
			jump_next = "]]",
			refresh = "gr",
		},
		neovide = {
			panel_open = "<M-CR>",
			suggestion_accept = "<D-CR>",
			suggestion_prev = "<D-[>",
			suggestion_next = "<D-]>",
			suggestion_dismiss = "<C-]>",
		},
		normal = {
			panel_open = "<D-CR>",
			suggestion_accept = "<A-CR>",
			suggestion_prev = "[[",
			suggestion_next = "]]",
			suggestion_dismiss = "}}",
		},
	},
	neovide = {
		save = "<D-s>",
		copy = "<D-c>",
		paste_normal = "<D-v>",
		paste_visual = "<D-v>",
		paste_cmd = "<D-v>",
		paste_insert = "<D-v>",
	},
	neo_tree = {
		navigate_up = "<bs>",
		set_root = ".",
		toggle_hidden = "H",
		fuzzy = "f",
		fuzzy_dir = "D",
		filter = "/",
		clear_filter = "<M-x>",
		prev_git = "[g",
		next_git = "]g",
	},
	mini_files = {
		open_float = "<Leader>O",
		open = "<Leader>o",
	},
}

function M.apply_core_keymaps(utils, format, typescript_organize_imports)
	local map = utils.map
	local vs_map = utils.vs_map
	local is_neovide = utils.is_neovide
	local key = M.keys.core

	vim.g.mapleader = M.leader

	map("v", key.visual_move_down, ":m '>+1<CR>gv=gv")
	map("v", key.visual_move_up, ":m '<-2<CR>gv=gv")

	map("i", key.insert_escape, "<Esc>")
	map("i", key.insert_delete_line, "<C-u>")
	map("i", key.insert_delete_word, "<C-w>")
	map("i", key.visual_move_down, "<Esc>:m .+1<CR>==gi")
	map("i", key.visual_move_up, "<Esc>:m .-2<CR>==gi")

	map("n", key.normal_move_down, ":m .+1<CR>==")
	map("n", key.normal_move_up, ":m .-2<CR>==")
	map("n", key.open_vsplit, "<Cmd>vs<CR><C-w>l<CR>")
	map("n", key.open_split, "<Cmd>sp<CR><C-w>j<CR>")
	map("n", key.split_to_horizontal, "<C-w>t<C-w>K")
	map("n", key.split_to_vertical, "<C-w>t<C-w>H")

	vs_map("n", key.navigate_left, "<C-w>h", function()
		require("vscode").call("workbench.action.navigateLeft")
	end)
	vs_map("n", key.navigate_down, "<C-w>j", function()
		require("vscode").call("workbench.action.navigateDown")
	end)
	vs_map("n", key.navigate_up, "<C-w>k", function()
		require("vscode").call("workbench.action.navigateUp")
	end, { noremap = true, silent = true })
	vs_map("n", key.navigate_right, "<C-w>l", function()
		require("vscode").call("workbench.action.navigateRight")
	end)

	map("n", key.save, "<Cmd>w<CR>")
	map("n", key.quit, "<Cmd>q<CR>")
	map("n", key.force_quit, "<Cmd>q!<CR>")
	map("n", key.force_quit_all, "<Cmd>qa!<CR>")

	vs_map("n", key.save_and_quit, "<Cmd>wq<CR>", function()
		require("vscode").call("workbench.action.files.save")
		require("vscode").call("workbench.action.closeActiveEditor")
	end)
	vs_map("n", key.save_file, "<Cmd>w<CR>", function()
		require("vscode").call("workbench.action.files.save")
	end)
	vs_map("n", key.save_all, "<Cmd>wa<CR>", function()
		require("vscode").call("workbench.action.files.saveAll")
	end)

	map("n", key.resize_inc, "<C-w>+")
	map("n", key.resize_dec, "<C-w>-")
	map("n", key.equalize, "<C-w>=")
	map("n", key.resize_more, '<Cmd>exe "resize " . (winheight(0) * 3/2)<CR>')
	map("n", key.resize_less, '<Cmd>exe "resize " . (winheight(0) * 2/3)<CR>')

	map("t", key.terminal_escape, "<C-\\><C-n>")
	map("n", key.new_tab, "<Cmd>tabnew<CR>")
	vs_map("n", key.next_tab, "<Cmd>tabnext<CR>", "<Cmd>Tabnext<CR>")
	vs_map("n", key.prev_tab, "<Cmd>tabprevious<CR>", "<Cmd>Tabprevious<CR>")
	vs_map("n", key.close_tab, "<Cmd>tabclose<CR>", "<Cmd>Tabclose<CR>")

	vs_map("n", key.format, format, '<Cmd>lua require("vscode").call("editor.action.formatDocument")<CR>')
	vs_map("n", key.organize_imports, typescript_organize_imports,
		'<Cmd>lua require("vscode").call("editor.action.organizeImports")<CR>')
	vs_map("n", key.split_editor, "<Cmd>split<CR>",
		'<Cmd>lua require("vscode").call("workbench.action.splitEditor")<CR>')
	vs_map("n", key.vsplit_editor, "<Cmd>vsplit<CR>", "<Cmd>Split<CR>")

	map("n", key.code_action, "<Cmd>lua vim.lsp.buf.code_action()<CR>")
	map("n", key.hop_char, "<Cmd>HopChar1<CR>")

	map("n", key.find_files, '<Cmd>lua require"telescope.builtin".find_files()<CR>')
	map("n", key.buffer_fuzzy, '<Cmd>lua require"telescope.builtin".current_buffer_fuzzy_find()<CR>')
	map("n", key.telescope_buffers, "<Cmd>Telescope buffers<CR>")
	map("n", key.telescope_help, "<Cmd>Telescope help_tags<CR>")
	map("n", key.telescope_commits, "<Cmd>Telescope git_commits<CR>")
	map("n", key.telescope_options, "<Cmd>Telescope vim_options<CR>")
	map("n", key.telescope_keymaps, "<Cmd>Telescope keymaps<CR>")
	map("n", key.telescope_projects, "<Cmd>Telescope projects<CR>")
	map("n", key.telescope_quickfix, "<Cmd>Telescope quickfix<CR>")
	map("n", key.telescope_diagnostics, "<Cmd>Telescope diagnostics<CR>")
	map("n", key.diagnostic_next, function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, { silent = true })
	map("n", key.diagnostic_prev, function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, { silent = true })
	map("n", key.diagnostic_float, function()
		vim.diagnostic.open_float()
	end, { silent = true })

	if is_neovide() then
		local nvk = M.keys.neovide
		map("n", nvk.save, "<Cmd>w<CR>")
		map("v", nvk.copy, '"+y')
		map("n", nvk.paste_normal, '"+P')
		map("v", nvk.paste_visual, '"+P')
		map("c", nvk.paste_cmd, "<C-R>+")
		map("i", nvk.paste_insert, '<ESC>l"+Pli')
	end
end

function M.apply_vscode_keymaps(vs_map, only_vscode_map, vscode)
	local key = M.keys.vscode

	only_vscode_map("v", key.visual_move_down, ":m '>+1<CR>gv=gv")
	only_vscode_map("v", key.visual_move_up, ":m '<-2<CR>gv=gv")

	only_vscode_map({ "n", "x", "i" }, key.multi_cursor, function()
		vscode.with_insert(function()
			vscode.action("editor.action.addSelectionToNextFindMatch")
		end)
	end, { noremap = true, silent = true })

	vs_map("n", key.rename, function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, '<Cmd>lua require("vscode").call("editor.action.rename")<CR>', { noremap = true, silent = true })

	vs_map("n", key.zen_mode, "<Cmd>ZenMode<CR>",
		'<Cmd>lua require("vscode").call("workbench.action.toggleZenMode")<CR>',
		{ noremap = true, silent = true })

	vs_map("n", key.quickfix, "<Cmd>lua vim.lsp.buf.code_action()<CR>",
		'<Cmd>lua require("vscode").call("editor.action.quickFix")<CR>',
		{ noremap = true, silent = true })

	vs_map("n", key.diagnostic_next, function()
		vim.diagnostic.jump({ count = 1, float = true })
	end,
		'<Cmd>lua require("vscode").call("editor.action.marker.next")<CR>',
		{ noremap = true, silent = true })

	vs_map("n", key.diagnostic_prev, function()
		vim.diagnostic.jump({ count = -1, float = true })
	end,
		'<Cmd>lua require("vscode").call("editor.action.marker.prev")<CR>',
		{ noremap = true, silent = true })
end

function M.apply_lsp_on_attach(utils)
	local map = utils.map
	local vs_map = utils.vs_map
	local key = M.keys.lsp

	map("n", key.code_action, "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
	map("i", key.completion, vim.lsp.buf.completion)

	vs_map("n", key.definition, Snacks.picker.lsp_definitions,
		'<Cmd>call VSCodeNotify("editor.action.goToDefinition")<CR>',
		{ noremap = true, silent = true })

	map("n", key.definition_tab, '<Cmd>tab split | lua require("telescope.builtin").lsp_definitions()<CR>',
		{ noremap = true, silent = true })

	vs_map("n", key.definition_vsplit, 'mmH<Cmd>vs<CR><C-w>l`m<Cmd>lua Snacks.picker.lsp_definitions()<CR>',
		"<Cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>",
		{ noremap = true, silent = true })

	map("n", key.definition_split, 'mmH<Cmd>sp<CR><C-w>j`m<Cmd>lua vim.lsp.buf.definition()<CR>',
		{ noremap = true, silent = true })

	map("n", key.hover, vim.lsp.buf.hover, { noremap = true, silent = true })

	vs_map("n", key.references, "<Cmd>lua Snacks.picker.lsp_references()<CR>",
		'<Cmd>call VSCodeNotify("editor.action.referenceSearch.trigger")<CR>',
		{ noremap = true, silent = true })

	vs_map("n", key.rename, function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, '<Cmd>call VSCodeNotify("editor.action.rename")<CR>', { expr = true })
end

function M.snacks_keys()
	return {
		{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>?", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
		{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
		{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
		{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		{ "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		{ "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		{ "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
		{ "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	}
end

function M.apply_snacks_toggles(Snacks)
	local t = M.keys.snacks_toggles
	Snacks.toggle.option("spell", { name = "Spelling" }):map(t.spell)
	Snacks.toggle.option("wrap", { name = "Wrap" }):map(t.wrap)
	Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map(t.relativenumber)
	Snacks.toggle.diagnostics():map(t.diagnostics)
	Snacks.toggle.line_number():map(t.line_numbers)
	Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(t.conceallevel)
	Snacks.toggle.treesitter():map(t.treesitter)
	Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(t.background)
	Snacks.toggle.inlay_hints():map(t.inlay_hints)
	Snacks.toggle.indent():map(t.indent)
	Snacks.toggle.dim():map(t.dim)
end

function M.oil_buffer_keymaps(save_oil_buffer, close_oil_buffer, discard_unsaved_changes)
	local key = M.keys.oil
	return {
		[key.help] = "actions.show_help",
		[key.select] = "actions.select",
		[key.vsplit] = "actions.select_vsplit",
		[key.split] = "actions.select_split",
		[key.tab] = "actions.select_tab",
		[key.preview] = "actions.preview",
		[key.close] = "actions.close",
		[key.refresh] = "actions.refresh",
		[key.parent] = "actions.parent",
		[key.open_cwd] = "actions.open_cwd",
		[key.cd] = "actions.cd",
		[key.tcd] = "actions.tcd",
		[key.sort] = "actions.change_sort",
		[key.external] = "actions.open_external",
		[key.hidden] = "actions.toggle_hidden",
		[key.trash] = "actions.toggle_trash",
		[key.save_buffer] = save_oil_buffer,
		[key.close_buffer] = close_oil_buffer,
		[key.discard_changes] = discard_unsaved_changes,
	}
end

function M.apply_oil_global_keymaps(vs_map, map, oil, oil_actions)
	local key = M.keys.oil
	vs_map("n", key.open_float, function()
		oil.toggle_float(oil.get_current_dir())
	end, '<Cmd>call VSCodeNotify("workbench.view.explorer")<CR>')

	vs_map("n", key.open, function()
		oil.open(oil.get_current_dir())
	end, "<Cmd>Ex<CR>")

	map("n", M.keys.core.oil_parent, function()
		vim.cmd("Oil")
	end)

	map("n", M.keys.core.oil_cwd, function()
		oil_actions.open_cwd.callback()
	end)
end

function M.telescope_default_mappings(actions)
	local key = M.keys.telescope
	return {
		i = {
			[key.send_to_qflist] = actions.send_to_qflist + actions.open_qflist,
			[key.preview_up] = actions.preview_scrolling_up,
			[key.preview_down] = actions.preview_scrolling_down,
			[key.disable_insert_down] = false,
		},
		n = {
			[key.preview_up] = actions.preview_scrolling_up,
			[key.preview_down] = actions.preview_scrolling_down,
		},
	}
end

function M.telescope_git_commit_mappings(view_on_diffview)
	local key = M.keys.telescope
	return {
		i = {
			[key.open_diffview] = view_on_diffview,
		},
		n = {
			[key.open_diffview] = view_on_diffview,
		},
	}
end

function M.nvim_cmp_mappings(cmp, luasnip, check_backspace)
	local key = M.keys.cmp
	return cmp.mapping.preset.insert({
		[key.complete] = cmp.mapping.complete(),
		[key.scroll_up] = cmp.mapping.scroll_docs(-4),
		[key.scroll_down] = cmp.mapping.scroll_docs(4),
		[key.confirm_select] = cmp.mapping.confirm({ select = true }),
		[key.confirm] = cmp.mapping.confirm({ select = false }),
		[key.next] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		[key.prev] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	})
end

function M.apply_barbar_keymaps(map, opts)
	local key = M.keys.barbar
	map("n", key.prev, "<Cmd>BufferPrevious<CR>", opts)
	map("n", key.next, "<Cmd>BufferNext<CR>", opts)
	map("n", key.next_tab, "<Cmd>BufferNext<CR>", opts)
	map("n", key.prev_tab, "<Cmd>BufferPrevious<CR>", opts)
	map("n", key.move_prev, "<Cmd>BufferMovePrevious<CR>", opts)
	map("n", key.move_next, "<Cmd>BufferMoveNext<CR>", opts)
	map("n", key.goto_1, "<Cmd>BufferGoto 1<CR>", opts)
	map("n", key.goto_2, "<Cmd>BufferGoto 2<CR>", opts)
	map("n", key.goto_3, "<Cmd>BufferGoto 3<CR>", opts)
	map("n", key.goto_4, "<Cmd>BufferGoto 4<CR>", opts)
	map("n", key.goto_5, "<Cmd>BufferGoto 5<CR>", opts)
	map("n", key.goto_6, "<Cmd>BufferGoto 6<CR>", opts)
	map("n", key.goto_7, "<Cmd>BufferGoto 7<CR>", opts)
	map("n", key.goto_8, "<Cmd>BufferGoto 8<CR>", opts)
	map("n", key.goto_9, "<Cmd>BufferGoto 9<CR>", opts)
	map("n", key.goto_last, "<Cmd>BufferLast<CR>", opts)
	map("n", key.pin, "<Cmd>BufferPin<CR>", opts)
	map("n", key.close, "<Cmd>BufferClose<CR>", opts)
	map("n", key.pick, "<Cmd>BufferPick<CR>", opts)
	map("n", key.order_buffer, "<Cmd>BufferOrderByBufferNumber<CR>", opts)
	map("n", key.order_directory, "<Cmd>BufferOrderByDirectory<CR>", opts)
	map("n", key.order_language, "<Cmd>BufferOrderByLanguage<CR>", opts)
	map("n", key.order_window, "<Cmd>BufferOrderByWindowNumber<CR>", opts)
end

function M.apply_harpoon_keymaps(map, harpoon)
	local key = M.keys.harpoon
	map("n", key.append, function() harpoon:list():append() end)
	map("n", key.menu, function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
	map("n", key.select_1, function() harpoon:list():select(1) end)
	map("n", key.select_2, function() harpoon:list():select(2) end)
	map("n", key.select_3, function() harpoon:list():select(3) end)
	map("n", key.select_4, function() harpoon:list():select(4) end)
end

function M.apply_zen_mode_keymap(map)
	map("n", M.keys.zen_mode.toggle, "<Cmd>ZenMode<CR>")
end

function M.copilot_config(is_neovide)
	local key = M.keys.copilot
	local base = {
		panel = {
			auto_refresh = false,
			keymap = {
				accept = key.panel.accept,
				jump_prev = key.panel.jump_prev,
				jump_next = key.panel.jump_next,
				refresh = key.panel.refresh,
			},
		},
		suggestion = {
			auto_trigger = true,
			keymap = {},
		},
	}

	if is_neovide then
		base.panel.keymap.open = key.neovide.panel_open
		base.suggestion.keymap.accept = key.neovide.suggestion_accept
		base.suggestion.keymap.prev = key.neovide.suggestion_prev
		base.suggestion.keymap.next = key.neovide.suggestion_next
		base.suggestion.keymap.dismiss = key.neovide.suggestion_dismiss
		return base
	end

	base.panel.keymap.open = key.normal.panel_open
	base.suggestion.keymap.accept = key.normal.suggestion_accept
	base.suggestion.keymap.prev = key.normal.suggestion_prev
	base.suggestion.keymap.next = key.normal.suggestion_next
	base.suggestion.keymap.dismiss = key.normal.suggestion_dismiss
	return base
end

function M.neo_tree_mappings()
	local key = M.keys.neo_tree
	return {
		[key.navigate_up] = "navigate_up",
		[key.set_root] = "set_root",
		[key.toggle_hidden] = "toggle_hidden",
		[key.fuzzy] = "fuzzy_finder",
		[key.fuzzy_dir] = "fuzzy_finder_directory",
		[key.filter] = "filter_on_submit",
		[key.clear_filter] = "clear_filter",
		[key.prev_git] = "prev_git_modified",
		[key.next_git] = "next_git_modified",
	}
end

function M.apply_mini_files_keymaps(vs_map, map)
	local key = M.keys.mini_files
	vs_map("n", key.open_float, "<Cmd>lua MiniFiles.open()<CR>",
		'<Cmd>call VSCodeNotify("workbench.view.explorer")<CR>')
	map("n", key.open, function()
		MiniFiles.open()
	end)
end

return M
