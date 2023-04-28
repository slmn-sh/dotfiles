vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },
  view = {
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "L", action = "vsplit_preview" },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all" }
      }
    }
  }
})

