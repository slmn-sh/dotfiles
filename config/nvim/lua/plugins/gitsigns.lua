local ok, gitsigns = pcall(require, 'gitsigns')

if ok then
    gitsigns.setup({
        signcolumn = false,
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 300
        },
    })
end
