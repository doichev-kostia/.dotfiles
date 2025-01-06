vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("doichev-kostia.set")
require("doichev-kostia.remap")
require("doichev-kostia.lazy")

vim.cmd[[colorscheme catppuccin-latte]]

pcall(require('telescope').load_extension, 'fzf')
