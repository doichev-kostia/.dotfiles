
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- move the selected line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the selected line up" })

-- sync the copy buffer with OS
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- automatically center the half-page jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

-- file explorer
vim.keymap.set("n", "<leader>pf", vim.cmd.Ex, { desc = "[P]roject [F]iles" })

-- for lua execution
vim.keymap.set("n", "<leader>ex", function()
    vim.cmd.write()
    vim.cmd("source %")
end, { desc = "Execute lua file" })
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- [[ Switch between buffers ]]
vim.keymap.set("n", "<C-TAB>", ":bnext<CR>", { silent = true, desc = "Next buffer" });
vim.keymap.set("n", "<S-C-TAB>", ":bprevious<CR>", { silent = true, desc = "Previous buffer"});
