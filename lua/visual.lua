-- require("kanagawa").load("wave") the default heart-warming theme,
-- require("kanagawa").load("dragon") for those late-night sessions
-- require("kanagawa").load("lotus") for when you're out in the open.
vim.cmd.colorscheme("kanagawa")
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.rehash256 = 1

local function short_mode()
    return vim.fn.mode()
end

require("lualine").setup({
  sections = {
    lualine_a = {short_mode},
    lualine_b = {'branch'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
    tabline = {
        lualine_a = {'buffers'},
    }
})

