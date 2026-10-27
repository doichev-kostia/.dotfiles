return {
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },


    -- {
    --     -- Autocompletion
    --     'hrsh7th/nvim-cmp',
    --     dependencies = {
    --         -- Snippet Engine & its associated nvim-cmp source
    --         'L3MON4D3/LuaSnip',
    --         'saadparwaiz1/cmp_luasnip',
    --
    --         -- Adds LSP completion capabilities
    --         'hrsh7th/cmp-nvim-lsp',
    --
    --         -- Adds a number of user-friendly snippets
    --         'rafamadriz/friendly-snippets',
    --     },
    -- },

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        opts = {},
        config = function(_, options)
            require('which-key').setup(options)

            require("which-key").add({
                { "<leader>d", group = "[D]ocument" },
                { "<leader>c", group = "[C]ode" },
                { "<leader>g", group = "[G]it" },
                { "<leader>h", group = "More git" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },
                { "<leader>w", group = "[W]orkspace" },
            })
        end,
    },
    -- {
    --     'folke/trouble.nvim',
    --     opts = {
    --         icons = false
    --     }
    -- },


    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',


        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },

}
