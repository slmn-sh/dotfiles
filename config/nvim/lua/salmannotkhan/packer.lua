vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.4",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use "jiangmiao/auto-pairs"
    use { "EdenEast/nightfox.nvim", config = function()
        vim.cmd [[ colorscheme carbonfox ]]
    end }
    use {
        "cormacrelf/dark-notify",
        config = function()
            require('dark_notify').run({
                schemes = {
                    dark = "carbonfox",
                    light = "dayfox"
                }
            })
        end
    }
    use {
        "nvim-treesitter/nvim-treesitter", run = ":TSUpdate"
    }
    use "nvim-treesitter/nvim-treesitter-context"
    use "mbbill/undotree"
    use {
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-git" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    }
    use {
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end
    }

    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            { "nvim-tree/nvim-web-devicons" }
        }
    }
    use "nvimtools/none-ls.nvim"
    use "tpope/vim-sleuth"
    use "tpope/vim-surround"

    use "lewis6991/gitsigns.nvim"
    use "b0o/schemastore.nvim"

    use "christoomey/vim-tmux-navigator"
end)
