--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
end

local servers = {
    gopls = {},
    rust_analyzer = {},
    tsserver = {},
    -- ocamllsp = {},
    html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
        },
    },
}

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
        },
        config = function ()
            -- local cmp = require('cmp')
            -- local cmp_lsp = require("cmp_nvim_lsp")
            -- local capabilities = vim.tbl_deep_extend(
            --     "force",
            --     {},
            --     vim.lsp.protocol.make_client_capabilities(),
            --     cmp_lsp.default_capabilities())

            -- require("fidget").setup({})
            --
            -- require('neodev').setup()
            require('mason').setup()
            local mason_lspconfig = require('mason-lspconfig');
            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        -- capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })
            -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
            --
            --
            -- cmp.setup({
            --     enabled = function()
            --         -- disable completion in comments
            --         local context = require 'cmp.config.context'
            --         -- keep command mode completion enabled when cursor is in a comment
            --         if vim.api.nvim_get_mode().mode == 'c' then
            --             return true
            --         else
            --             return not context.in_treesitter_capture("comment") 
            --                 and not context.in_syntax_group("Comment")
            --         end
            --     end,
            --     snippet = {
            --         expand = function(args)
            --             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            --         end,
            --     },
            --     mapping = cmp.mapping.preset.insert({
            --         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            --         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            --         ["<CR>"] = cmp.mapping({
            --             i = function(fallback)
            --                 if cmp.visible() and cmp.get_active_entry() then
            --                     cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            --                 else
            --                     fallback()
            --                 end
            --             end,
            --             s = cmp.mapping.confirm({ select = true }),
            --             c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            --         }),
            --         ["<C-Space>"] = cmp.mapping.complete()
            --     }),
            --     sources = cmp.config.sources(
            --         {
            --             { name = 'nvim_lsp' },
            --             { name = 'luasnip' }, -- For luasnip users.
            --         },
            --         {
            --             { name = 'buffer' },
            --         }
            --     )
            -- })

            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

        end
    },
}
