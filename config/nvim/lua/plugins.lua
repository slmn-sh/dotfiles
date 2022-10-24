local ok, packer = pcall(require, "packer")

if ok then
  return packer.startup(function (use)

    use 'wbthomason/packer.nvim'

    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-git"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "folke/neodev.nvim"
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
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }
    use "saadparwaiz1/cmp_luasnip"

    use "tomasiser/vim-code-dark"
    use "mortepau/codicons.nvim"

    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "nvim-treesitter/nvim-treesitter-context"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "ryanoasis/vim-devicons"
    use "mhinz/vim-rfc"


    use "preservim/nerdcommenter"

    use "tpope/vim-sleuth"

    use "lewis6991/gitsigns.nvim"

    use "jose-elias-alvarez/null-ls.nvim"

    use "sainnhe/sonokai"
    use "sainnhe/everforest"
    use "sainnhe/gruvbox-material"
    use "joshdick/onedark.vim"
    use 'mfussenegger/nvim-dap'

    use 'fladson/vim-kitty'

  end)
end
