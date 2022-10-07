require("plugins.mason")
require("plugins.null_ls")
require("plugins.gitsigns")
require("plugins.nvim_tree")
require("autocmd.lsp")
require("plugins.cmp")
require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup { check_ts = true }
require("nvim-ts-autotag").setup()
require("statusline")

vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { pattern = { "*.rs" }, command = "RustFmt" }
)
