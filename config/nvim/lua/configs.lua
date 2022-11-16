vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.scrolloff = 10

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.termguicolors = true
vim.o.guifont = "codicon"
vim.o.encoding = "utf-8"

vim.o.completeopt = "menu,menuone,noselect"
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = false

vim.o.foldenable = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.updatetime = 100
vim.wo.signcolumn = 'yes'
vim.o.incsearch = false

vim.o.splitbelow = true
vim.o.splitright = true

vim.g.mapleader = ' '

vim.o.mouse = ''

-- NetRW configs
vim.g.netrw_banner = false
