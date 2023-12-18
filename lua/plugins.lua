return require('packer').startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- utility
    use "neovim/nvim-lspconfig"
    use "tpope/vim-surround"
    use "tpope/vim-fugitive"
    use "habamax/vim-godot"
    use "nvim-tree/nvim-web-devicons"
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    use "windwp/nvim-autopairs"
    use "jremmen/vim-ripgrep"
    use "vimwiki/vimwiki"
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- visual
    use "kvrohit/mellow.nvim"
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- For LSP autocomplete
    use "hrsh7th/nvim-cmp"         -- Autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp"     -- LSP source for nvim-cmp
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "L3MON4D3/LuaSnip"         -- Snippets plugin
    use "hrsh7th/cmp-buffer"       -- Buffers as a source
    use "onsails/lspkind.nvim"     -- Kind icons

    -- Treesitter
    -- usage :TSInstall <some_lang>
    -- will compile a parser
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "nvim-treesitter/nvim-treesitter-refactor"
end)
