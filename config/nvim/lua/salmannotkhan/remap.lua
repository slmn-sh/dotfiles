vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<leader>fm", ":Neotree<cr>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-h", ":TmuxNavigateLeft<cr>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-l", ":TmuxNavigateRight<cr>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-j", ":TmuxNavigateDown<cr>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<C-k", ":TmuxNavigateUp<cr>" ,{silent = true, noremap = true})
