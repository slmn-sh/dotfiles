local builtins = require("null-ls.builtins")

require("null-ls").setup({
    sources = {
        builtins.formatting.prettier.with({
            extra_filetypes = { "astro" },
        }),
        builtins.formatting.sql_formatter,
        builtins.diagnostics.gitlint.with({
            extra_args = { "--contrib=contrib-title-conventional-commits" }
        }),
        builtins.formatting.djlint,
        builtins.diagnostics.djlint,
        builtins.diagnostics.mypy,
    },
})
