local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>l", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

local comment_map = vim.loop.os_uname().sysname == "Darwin" and "<C-/>" or "<C-_>"

vim.api.nvim_set_keymap("n", comment_map, ":call nerdcommenter#Comment('n', 'toggle')<CR>", opts)
vim.api.nvim_set_keymap("v", comment_map, ":call nerdcommenter#Comment('x', 'toggle')<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>b", ":NvimTreeToggle<CR>", opts)
