return {
    'nvim-lua/plenary.nvim',

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
        },
    },

    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    {
        'github/copilot.vim',
    },

}
