local utils = require("utils")
local home = vim.env.HOME

-- for nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Tab settings, 4 spaces by default
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Undo, cache and backup directories.
-- Directories have to exist.
local undo_dir = "undo-dir"
local backup_dir = "backups"
local swap_dir = "swap"

vim.opt.undofile = true
if utils.is_windows() then
    vim.opt.undodir = home .. "\\.vim\\" .. undo_dir
    vim.opt.backupdir = home .. "\\.vim\\" .. backup_dir
    vim.opt.dir = home .. "\\.vim\\" .. swap_dir
else
    vim.opt.undodir = home .. "/.vim/" .. undo_dir
    vim.opt.backupdir = home .. "/.vim/" .. backup_dir
    vim.opt.dir = home .. "/.vim/" .. swap_dir
end

vim.opt.showtabline = 0      -- always show tabs in gvim, but not vim
vim.opt.colorcolumn = "120"  -- add red column for line limit (probably should be set in ftypes
vim.opt.scrolloff = 8        -- minimal number of screen lines to keep above and below the cursor.
vim.opt.ignorecase = true    -- ignore case in searches.
vim.opt.hlsearch = false     -- don't highlight search results.
vim.opt.incsearch = true     -- While typing a search command, show where the pattern, as it was typed so far, matches
vim.opt.rnu = true           -- hybrid line number mode
vim.opt.nu = true            -- hybrid line number mode
vim.opt.cul = false           -- highlight current line
vim.opt.joinspaces = false   -- Prevents inserting two spaces after punctuation on a join (J)
vim.opt.splitbelow = true    -- Horizontal split below current.
vim.opt.splitright = true    -- Vertical split to right of current.
vim.opt.hidden = true        -- Allow unsaved buffers
vim.opt.scl = "yes"          -- Set signcolumn for LSP information
vim.cmd.syntax("enable")

vim.opt.diffopt:append("vertical")       -- Diffs always vertical
vim.opt.fileformats = { "unix", "dos" }  -- Windows bad.

-- use only lua based filetype detection
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- These patterns don't deserve our love and shouldn't be shown in menus.
-- Set search paths in ./after/ftplugin/somefiletypename.vim.
-- More in :h ftplugin
vim.opt.wildignore:append { "**/node_modules/**", "*/dist/*","*/target/*","*/build/*" }

-- Visuals
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.rehash256 = 1

-- Show trailing spaces
vim.opt.list = true
vim.opt.listchars:append {
    tab = "  ",
    trail = "·",
}
