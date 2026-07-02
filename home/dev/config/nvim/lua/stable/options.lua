local o = vim.o

-- Undo file configuration
local undo_file_dir = os.getenv("HOME") .. '/.nvim/undo_file_dir'
if not vim.uv.fs_stat(undo_file_dir) then
	vim.fn.system({
		"mkdir",
		"-p",
		undo_file_dir,
	})
end
o.undodir = undo_file_dir
o.undofile = true

o.clipboard ="unnamedplus"
o.number = true
o.relativenumber = true
o.termguicolors = true
o.ttyfast = true
o.cursorline = false
o.tabstop = 2
-- o.shiftwidth = 2

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"

vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- autoread when a file is changed from the outside of vim
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

if vim.g.neovide then
	o.guifont = "Liga SFMono Nerd Font:h22"
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
end
