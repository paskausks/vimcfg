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
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      config = function()
        require('nvim-treesitter').install { 'gdscript', 'odin' }
      end,
      build = ':TSUpdate'
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
            { "<C-p>", "<cmd>FzfLua global<cr>", desc = "FZF global" },
            { "<C-t>", "<cmd>FzfLua tags<cr>", desc = "FZF tags" },
        },
        opts = {
            file_ignore_patterns = require("file_ignore_patterns")
        }
    },
    {
        'stevearc/aerial.nvim',
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
        },
        config = function()
            require("aerial").setup({
              open_automatic = false,
              ignore = {
                filetypes = {
                    "markdown",
                    "gitcommit",
                }
              },
              layout = {
                default_direction = "left",
                min_width = 40,
              }
            })
        end,
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

    -- For LSP autocomplete
    {
        'saghen/blink.cmp',
        version = "1.*",
        opts = require("blinkcmp_opts"),
        opts_extend = { "sources.default" }
    },
})
