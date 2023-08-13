vim.cmd.colorscheme("nightfox")
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.rehash256 = 1

require("lualine").setup({
    tabline = {
        lualine_a = {'buffers'},
    }
})

