local ok, nvim_tree = pcall(require, "nvim-tree")

if ok then
    nvim_tree.setup({
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = true,
        view = {
            adaptive_size = true,
            side = "right",
            hide_root_folder = true,
            mappings = {
                list = {
                    { key = "l", action = "edit" },
                    { key = "h", action = "close_node" }
                }
            }
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true
        },
        filters = {
            custom = {
                ".git"
            }
        },
        renderer = {
            highlight_opened_files = "all"
        },
    })
end
