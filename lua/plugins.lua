local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- utility
    "neovim/nvim-lspconfig",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
         config = require("gitsigns_setup"),
    },
    "habamax/vim-godot",
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
    "jremmen/vim-ripgrep",
    "vimwiki/vimwiki",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    "chaoren/vim-wordmotion",

    -- visual
    "ap/vim-buftabline",
    "yorickpeterse/vim-paper",

    -- For LSP autocomplete
    "hrsh7th/nvim-cmp",         -- Autocompletion plugin
    "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
    "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
    "L3MON4D3/LuaSnip",         -- Snippets plugin
    "hrsh7th/cmp-buffer",       -- Buffers as a source
    "onsails/lspkind.nvim",     -- Kind icons

    -- Treesitter
    -- usage :TSInstall <some_lang>
    -- will compile a parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    "nvim-treesitter/nvim-treesitter-refactor",
})
