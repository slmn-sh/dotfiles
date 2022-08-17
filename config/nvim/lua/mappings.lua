local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-P>", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-G>", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-_>", ":call nerdcommenter#Comment('n', 'toggle')<CR>", opts)
vim.api.nvim_set_keymap("v", "<C-_>", ":call nerdcommenter#Comment('x', 'toggle')<CR>", opts)

vim.api.nvim_set_keymap("n", "<C-f>", ":NvimTreeToggle<CR>", opts)
