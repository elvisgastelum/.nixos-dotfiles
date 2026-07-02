-----------------------------------------------------------
-- Define keymaps of Neovim.
-----------------------------------------------------------

local utils = require "stable.utils"

local map = utils.map
local vs_map = utils.vs_map
local is_neovide = utils.is_neovide
local format = utils.custom_format.format
local typescript_organize_imports = utils.typescript.organize_imports

-- Change leader to a space
vim.g.mapleader = " "

local leader = '<Leader>'

-----------------------------------------------------------
-- Neovim shortcuts
-- OPT/ALT 	- 	<M-...> / <A-...>
-- CMD 		- 	<D-...>
-- CTRL		-	<C-...>
-- Shift	-	<S-...>
-- Return	-	<CR>
-- Backspace	-	<BS>
-- Space	-	<Space>
-- Escape	-	<Esc>
-----------------------------------------------------------

-- Visual mode --------------------------------------------

-- Move selected line / block of text in visual mode
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Insert mode --------------------------------------------

-- Exit from inser mode
map("i", "jj", "<Esc>")

-- CMD + Backspace delete line
map("i", "<D-BS>", "<C-u>")

-- OPT/ALT + Backspace delete word
map("i", "<M-BS>", "<C-w>")

-- Move selected line / block of text in insert mode
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')

-- Normal mode --------------------------------------------

-- Move selected line / block of text in normal mode
map('n', '<A-j>', ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")

-- Open panel in vertical mode
map("n", '<C-v>', '<Cmd>vs<CR><C-w>l<CR>')

-- Open panel in horizontal mode
map('n', '<C-s>', '<Cmd>sp<CR><C-w>j<CR>')

-- Open file browser in current workspace
-- vs_map('n', leader .. 'of', '<Cmd>Neotree reveal<CR>', '<Cmd>call VSCodeNotify("workbench.view.explorer")<CR>')

-- Open Netrw in current workspace on a window
-- map('n', leader .. 'e', '<Cmd>e .<CR>')

-- Change split orientation
map('n', leader .. 'clh', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', leader .. 'clv', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vs_map('n', '<C-h>', '<C-w>h', function()
	require("vscode").call("workbench.action.navigateLeft")
end)
vs_map('n', '<C-j>', '<C-w>j', function()
	require("vscode").call("workbench.action.navigateDown")
end)
vs_map('n', '<C-k>', '<C-w>k', function()
	require("vscode").call("workbench.action.navigateUp")
end, { noremap = true, silent = true })
vs_map('n', '<C-l>', '<C-w>l', function()
	require("vscode").call("workbench.action.navigateRight")
end)

-- Fast saving with <leader> and s
map('n', leader .. 's', '<Cmd>w<CR>')

-- Close current window with <leader> and q
map('n', leader .. 'q', '<Cmd>q<CR>')

-- Force close current window with Ctrl + q
map('n', '<C-q>', '<Cmd>q!<CR>')

-- Force close all windows with Ctrl + Q
map('n', '<C-S-q>', '<Cmd>qa!<CR>')

-- Save and close current window with <leader> and wq
vs_map('n', leader .. 'wq', '<Cmd>wq<CR>', function()
	require("vscode").call("workbench.action.files.save")
	-- Tab close
	require("vscode").call("workbench.action.closeActiveEditor")
end)

-- Save file
vs_map('n', leader .. 'ww', '<Cmd>w<CR>', function()
	require("vscode").call("workbench.action.files.save")
end)

-- Save all files
vs_map('n', leader .. 'wa', '<Cmd>wa<CR>', function()
	require("vscode").call("workbench.action.files.saveAll")
end)

-- Save and source current file
-- map('n', leader .. 'wr', '<Cmd>w<CR><Cmd>so %<CR><Cmd>lua print("File Reloaded")<CR>')

-- Resize window
map('n', '<M-=>', '<C-w>+')
map('n', '<M-->', '<C-w>-')

-- Set panes to same size
map('n', '<M-+>', '<C-w>=')

-- Resize more space at once
map('n', leader .. '=', '<Cmd>exe "resize " . (winheight(0) * 3/2)<CR>')
map('n', leader .. '-', '<Cmd>exe "resize " . (winheight(0) * 2/3)<CR>')


-- Exit from terminal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- Open new tab with empty buffer
map('n', 'tN', '<Cmd>tabnew<CR>')

-- Open next tab
vs_map('n', 'tn', '<Cmd>tabnext<CR>', '<Cmd>Tabnext<CR>')

-- Open previous tab
vs_map('n', 'tp', '<Cmd>tabprevious<CR>', '<Cmd>Tabprevious<CR>')

-- Close current tab
vs_map('n', 'xx', '<Cmd>tabclose<CR>', '<Cmd>Tabclose<CR>')

-- Format document
vs_map('n', 'fo', format, '<Cmd>lua require("vscode").call("editor.action.formatDocument")<CR>')
-- vs_map('n', 'fo', '<Cmd>Format<CR>', '<Cmd>call VSCodeNotify("editor.action.formatDocument")<CR>')

-- Format code and save
-- vs_map('n', leader .. 'wf', '<Cmd>LspZeroFormat<CR><Cmd>w<CR>',
-- 	'<Cmd>call VSCodeNotify("workbench.action.files.save")<CR>')

-- Typescript organize imports and format
vs_map('n', 'so', typescript_organize_imports, '<Cmd>lua require("vscode").call("editor.action.organizeImports")<CR>')

-- Split window
vs_map('n', 'sp', '<Cmd>split<CR>', '<Cmd>lua require("vscode").call("workbench.action.splitEditor")<CR>')
vs_map('n', 'hp', '<Cmd>vsplit<CR>', '<Cmd>Split<CR>')

map('n', leader .. 'a', '<Cmd>lua vim.lsp.buf.code_action()<CR>')

-- HOP keybindings
map('n', leader .. 'j', '<Cmd>HopChar1<CR>')

-- Telescope
map('n', leader .. 'ff', '<Cmd>lua require"telescope.builtin".find_files()<CR>')
-- MOVED: to snacks.lua
-- map('n', leader .. '?', '<Cmd>lua require"telescope.builtin".live_grep()<CR>')
map('n', leader .. '/', '<Cmd>lua require"telescope.builtin".current_buffer_fuzzy_find()<CR>')
map('n', leader .. 'fb', '<Cmd>Telescope buffers<CR>')
map('n', leader .. 'fh', '<Cmd>Telescope help_tags<CR>')
map('n', leader .. 'fc', '<Cmd>Telescope git_commits<CR>')
map('n', leader .. 'fo', '<Cmd>Telescope vim_options<CR>')
map('n', leader .. 'fk', '<Cmd>Telescope keymaps<CR>')
map('n', leader .. 'fp', '<Cmd>Telescope projects<CR>')
map('n', leader .. 'fq', '<Cmd>Telescope quickfix<CR>')
map('n', leader .. 'fd', '<Cmd>Telescope diagnostics<CR>')

-- Neovide
if is_neovide() then
	map('n', '<D-s>', '<Cmd>w<CR>') -- Save
	map('v', '<D-c>', '"+y')  -- Copy
	map('n', '<D-v>', '"+P')  -- Paste normal mode
	map('v', '<D-v>', '"+P')  -- Paste visual mode
	map('c', '<D-v>', '<C-R>+') -- Paste command mode
	map('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
