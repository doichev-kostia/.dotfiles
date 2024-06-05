return {
    'nvim-lua/plenary.nvim',

    {
        "rose-pine/neovim",
        as = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                variant = 'dawn',
                enable = {
                    terminal = true,
                    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                    migrations = true, -- Handle deprecated options automatically
                },
            })
        end,
    },

    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    {
        'github/copilot.vim',
    },

}
