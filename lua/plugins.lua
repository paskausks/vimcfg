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
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "chaoren/vim-wordmotion",

    -- visual
    "ap/vim-buftabline",
    "yorickpeterse/vim-paper",  -- Minimalistic light theme
    "aliqyan-21/darkvoid.nvim", -- Very minimalistic dark theme

    -- Autocomplete for LSP
    {
        "saghen/blink.cmp",
        version = "v0.13.1",
        dependencies = {
            "L3MON4D3/LuaSnip",         -- Snippets plugin
        },
    },

    -- Treesitter
    -- usage :TSInstall <some_lang>
    -- will compile a parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    "nvim-treesitter/nvim-treesitter-refactor",
})
