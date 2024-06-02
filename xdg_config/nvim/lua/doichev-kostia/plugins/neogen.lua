
-- Is it possible to generate annotations when typing the comment on top of the function?
-- Like its done in IntelliJ IDEA
-- /** + Enter and the IDE generates the annotations for the function


return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")

        neogen.setup({
            snippet_engine = "luasnip"
        })

        vim.keymap.set("n", "<leader>nf", function()
            neogen.generate({ type = "func" })
        end, { desc = "Generate function snippet" })

        vim.keymap.set("n", "<leader>nt", function()
            neogen.generate({ type = "type" })
        end, { desc = "Generate type snippet" })

    end,
}
