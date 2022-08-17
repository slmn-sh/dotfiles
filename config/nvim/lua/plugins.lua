return require("packer").startup(function (use)

    use 'wbthomason/packer.nvim'

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-git"
    use "hrsh7th/cmp-cmdline"
    use "folke/lua-dev.nvim"
    use "b0o/schemastore.nvim"

    use 'simrat39/rust-tools.nvim'

    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"

    use { 'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      tag = 'nightly'
    }

    use "rafamadriz/friendly-snippets"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"

    use "tomasiser/vim-code-dark"
    use "mortepau/codicons.nvim"

    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "ryanoasis/vim-devicons"
    use "mhinz/vim-rfc"

    use "preservim/nerdcommenter"

    use { "prettier/vim-prettier", run = "yarn install --frozen-lockfile --production" }

    use "jose-elias-alvarez/null-ls.nvim"

    use "tpope/vim-sleuth"

end)

