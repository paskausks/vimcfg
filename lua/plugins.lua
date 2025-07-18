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
    {
        "neovim/nvim-lspconfig",
        config = require("lsp_setup"),
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy",
        config = function()
            -- Surround options (decimals equal to ASCII codes and '\r' is the text to be
            -- surrounded)
            vim.g.surround_40 = "(\r)"
            vim.g.surround_91 = "[\r]"
        end,
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        config = function ()
            vim.opt.statusline = "%{FugitiveStatusline()} " .. vim.opt.statusline:get()
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = require("gitsigns_setup"),
        event = "VeryLazy"
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>ff", "<cmd>NvimTreeOpen<cr>", desc = "Open NvimTree" },
        },
        opts = {} -- explicitly call setup()
    },
    {
        "jremmen/vim-ripgrep",
        cmd = "Rg", -- load on command
    },
    {
        "vimwiki/vimwiki",
        ft = "markdown", -- load on opening a markdown file
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<C-p>", "<cmd>FzfLua files<cr>", desc = "FZF files" },
        },
    },
    {
        "chaoren/vim-wordmotion",
        event = "VeryLazy"
    },

    -- visual
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "BufAdd",
        opts = {
            options = {
                -- basically, emulate vim-buftabline
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
            },
        }
    },
    {
        "yorickpeterse/vim-paper",  -- Minimalistic light theme
        lazy = true, -- just don't load for now
    },
    {
        "owickstrom/vim-colors-paramount", -- minimalistic dark theme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd.colorscheme("paramount")
        end,
    },
    {
        "aliqyan-21/darkvoid.nvim", -- Very minimalistic dark theme
        lazy = true, -- just don't load for now
    },

    -- For LSP autocomplete
    {
        "hrsh7th/nvim-cmp",         -- Autocompletion plugin
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "L3MON4D3/LuaSnip",         -- Snippets plugin
            "hrsh7th/cmp-buffer",       -- Buffers as a source
            "onsails/lspkind.nvim",     -- Kind icons
        },
        config = require("nvim_cmp_setup"),
    },
    {
        "L3MON4D3/LuaSnip",         -- Snippets plugin
        lazy = true,
        config = function()
            -- use snipmate snippets with luasnip
            require("luasnip.loaders.from_snipmate").lazy_load()

            local ls = require("luasnip")
            vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
        end,
    },

    -- Treesitter
    -- usage :TSInstall <some_lang>
    -- will compile a parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
        config = require("treesitter_setup"),
        event = "BufAdd",
    },
})
