local ok, null_ls = pcall(require, "null-ls")

if ok then
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.gitlint.with({
                extra_args = { "--contrib=contrib-title-conventional-commits" }
            }),
        },
    })
end
