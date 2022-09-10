local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local lspconfig = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
local luasnip = require("luasnip")
local luadev = require("lua-dev").setup({})
local null_ls = require("null-ls")

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

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())


local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    on_attach = function(_, _)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
) or {}


require("mason").setup()
mason_lsp.setup({
    automatic_installation = true,
})
mason_lsp.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities
        }
    end,
    ["rust_analyzer"] = function()
        require("rust-tools").setup {}
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup(luadev)
    end,
    ["eslint"] = function()
        lspconfig.eslint.setup({
            handlers = {
                ['window/showMessageRequest'] = function(_, result, _) return result end
            }
        })
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup({
            settings = {
                yaml = {
                    schemas = require('schemastore').json.schemas(),
                }
            }
        })
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true }
                }
            }
        })
    end,
    ["sqls"] = function()
        lspconfig.sqls.setup({
            settings = {
                sqls = {
                    connections = {
                        {
                            driver = 'postgresql',
                            dataSourceName = "postgresql://postgres:test1234@localhost:5432/mydb"
                        }
                    }
                }
            }
        })
    end,
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-b>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
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

vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

        -- Jumps to the definition of the type symbol
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

        -- Lists all the references
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Displays a function's signature information
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', 'ca', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

        -- Show diagnostics in a floating window
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

        -- Move to the previous diagnostic
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

        -- Move to the next diagnostic
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})


cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
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

vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    { pattern = { "*.rs" }, command = "RustFmt" }
)

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require("nvim-tree").setup({
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
    }
})

require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup { check_ts = true }
require('nvim-ts-autotag').setup()

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.gitlint.with({
            extra_args = { "--contrib=contrib-title-conventional-commits" }
        })
    },
})

require("gitsigns").setup({
    signcolumn = false,
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300
    }
})
