return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon");

        harpoon:setup({});

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add current file to harpoon" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon" })
    end
}
