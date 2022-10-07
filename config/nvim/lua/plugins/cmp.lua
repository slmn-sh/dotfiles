local ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")

local cmp_kinds = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

if ok then
    cmp.setup({
        snippet = {
            expand = function(args)
                if luasnip_ok then
                    luasnip.lsp_expand(args.body)
                end
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-f>"] = cmp.mapping.scroll_docs(-4),
            ["<C-b>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip_ok then
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip_ok then
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua" },
            { name = "path" },
        }, {
                { name = "buffer" },
            }),
        formatting = {
            format = function(_, vim_item)
                vim_item.kind = string.format("%s %s", cmp_kinds[vim_item.kind], vim_item.kind)
                return vim_item
            end
        },
        experimental = {
            ghost_text = true,
        }
    })

    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "cmp_git" },
        }, {
            { name = "buffer" },
        })
    })


    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" }
        }
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" }
        }, {
            { name = "cmdline" }
        })
    })

    local autopairs_ok, autopairs = pcall(require, "cmp_autopairs")
    if autopairs_ok then
        cmp.event:on(
            'confirm_done',
            autopairs.on_confirm_done()
        )
    end
end
