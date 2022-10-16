local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local schemastore_ok, schemastore = pcall(require, "schemastore")
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local neodev_ok, neodev = pcall(require, "neodev")

local schemas = {}
local capabilities = {}

if mason_ok then
    mason.setup({
        check_outdated_packages_on_open = true,
    })
end

if schemastore_ok then
    schemas = schemastore.json.schemas()
end

if cmp_nvim_lsp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local lsp_defaults = {
    capabilities = capabilities,
    on_attach = function(_, _)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
    "force",
    lspconfig.util.default_config,
    lsp_defaults
) or {}

if neodev_ok then
    neodev.setup({})
end

if mason_lsp_ok and lspconfig_ok then
    mason_lsp.setup({
        automatic_installation = true,
    })
    mason_lsp.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup {}
        end,
        ["rust_analyzer"] = function()
            require("rust-tools").setup {}
        end,
        ["sumneko_lua"] = function()
            lspconfig.sumneko_lua.setup({
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                }
            })
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
                        schemas = schemas
                    }
                }
            })
        end,
        ["jsonls"] = function()
            lspconfig.jsonls.setup({
                settings = {
                    json = {
                        schemas = schemas,
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
end
