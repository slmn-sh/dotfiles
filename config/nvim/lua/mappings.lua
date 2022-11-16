local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>l", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

vim.api.nvim_set_keymap("n", "<C-_>", ":call nerdcommenter#Comment('n', 'toggle')<CR>", opts)
vim.api.nvim_set_keymap("v", "<C-_>", ":call nerdcommenter#Comment('x', 'toggle')<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>b", ":NvimTreeToggle<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>p", ":lua vim.lsp.buf.format({ name = 'null-ls' })<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>p", ":lua vim.lsp.buf.format({ name = 'null-ls' } )<CR>", opts)
