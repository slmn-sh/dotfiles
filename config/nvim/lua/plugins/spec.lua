return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "cormacrelf/dark-notify",
    lazy = false,
    priority = 1000,
    config = function()
      require("dark_notify").run({
        schemes = {
          dark = "carbonfox",
          light = "dayfox"
        }
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = { { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope-media-files.nvim', 'nvim-lua/popup.nvim' } },
    config = function()
      require('telescope').load_extension('media_files')
    end,
    keys = {
      { "<leader>ff", ":Telescope find_files<cr>", silent = true },
      { "<leader>fg", ":Telescope live_grep<cr>",  silent = true }
    }
  },
  {
    "jiangmiao/auto-pairs"
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        mode = "topline"
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup {
        sync_install = true,
        auto_install = false,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
      }
    end
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", ":UndotreeToggle<cr>", silent = true }
    },
  },
  {
    {
      'williamboman/mason.nvim',
      lazy = false,
      opts = {},
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          -- follow latest release.
          version = "v2.*",           -- Replace <CurrentMajor> by the latest released major (first number of latest release)
          -- install jsregexp (optional!).
          build = "make install_jsregexp"
        },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" }
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
          sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'luasnip', option = { use_show_condition = false }, },
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end,
              { "i", "s" }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end,
              { "i", "s" }),
          }),
          snippet = {
            expand = function(args)
              require 'luasnip'.lsp_expand(args.body)
            end,
          },
        })
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })
      end
    },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
      },
      init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = 'yes'
      end,
      config = function()
        local lsp_defaults = require('lspconfig').util.default_config

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        lsp_defaults.capabilities = vim.tbl_deep_extend(
          'force',
          lsp_defaults.capabilities,
          require('cmp_nvim_lsp').default_capabilities()
        )

        -- LspAttach is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<leader>p', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          end,
        })

        require('mason-lspconfig').setup({
          ensure_installed = {},
          handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
              require('lspconfig')[server_name].setup({})
            end,
          }
        })
      end
    }
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    keys = {
      { "<leader>fm", ":Neotree<cr>", silent = true }
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node"
          },
        },
      })
    end
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
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
          builtins.formatting.black,
          builtins.diagnostics.mypy
        },
      })
    end
  },
  { "tpope/vim-sleuth" },
  { "tpope/vim-surround" },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup({
        signcolumn = false,
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 300
        },
      })
    end
  },
  { "b0o/schemastore.nvim" },
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", ":TmuxNavigateLeft<cr>",  silent = true },
      { "<C-l>", ":TmuxNavigateRight<cr>", silent = true },
      { "<C-j>", ":TmuxNavigateDown<cr>",  silent = true },
      { "<C-k>", ":TmuxNavigateUp<cr>",    silent = true },
    },
    enabled = true
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        top_down = false
      })
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,             -- requires hrsh7th/nvim-cmp
          },
          hover = {
            silent = true
          }
        },
        views = {
          notify = {
            replace = true
          }
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,                   -- use a classic bottom cmdline for search
          command_palette = true,                 -- position the cmdline and popupmenu together
          long_message_to_split = true,           -- long messages will be sent to a split
          inc_rename = true,                      -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,                  -- add a border to hover docs and signature help
        },
      })
    end
  },
  {
    "folke/zen-mode.nvim",
    lazy = false,
    dependencies = {
      "folke/twilight.nvim"
    },
    keys = {
      { "<leader>z", ":ZenMode<cr>", silent = true },
    },
    opts = {
      plugins = {
        tmux = { enabled = true }
      }
    }
  },
  { 'akinsho/git-conflict.nvim', version = "*", config = true }
}
