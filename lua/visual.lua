vim.cmd.colorscheme("dayfox")
vim.opt.background = "light"
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

