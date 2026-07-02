return {
    'sindrets/diffview.nvim',
    lazy = true,
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
	    require('diffview').setup()
    end,
}
