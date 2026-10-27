-- Path of the current file from the workspace root, like Zed and IntelliJ show
-- it. The root is the outermost git repository: a `.git` directory, so
-- submodules (whose `.git` is a file) resolve to their superproject.
local function workspace_path()
    local file = vim.api.nvim_buf_get_name(0)
    if file == '' or vim.bo.buftype ~= '' then
        return ''
    end
    -- Cached per buffer: lualine redraws often and the root lookup stats every
    -- parent directory.
    if vim.b.workspace_path_for ~= file then
        local root = vim.fs.root(file, function(name, path)
            return name == '.git' and vim.fn.isdirectory(vim.fs.joinpath(path, name)) == 1
        end)
        vim.b.workspace_path = (root and vim.fs.relpath(root, file)) or vim.fn.fnamemodify(file, ':~:.')
        vim.b.workspace_path_for = file
    end
    return vim.b.workspace_path .. (vim.bo.modified and ' [+]' or '')
end

return {
    -- {
    --     "folke/zen-mode.nvim",
    --     opts = {}
    -- },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'rose-pine',
                component_separators = '|',
                section_separators = '',
            },
            winbar = { lualine_c = { workspace_path } },
            inactive_winbar = { lualine_c = { workspace_path } },
        },
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                    end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
            end,
        },
    },
}
