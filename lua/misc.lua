-- use defaults for nvim autoparis
require("nvim-autopairs").setup {}

-- use snipmate snippets with luasnip
require("luasnip.loaders.from_snipmate").lazy_load()

-- NERDCOMMENTER defaults
-- Create default mappings
vim.g.NERDCreateDefaultMappings = 1

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Surround options (decimals equal to ASCII codes and '\r' is the text to be
-- surrounded)
vim.g.surround_40 = "(\r)"
vim.g.surround_91 = "[\r]"

-- Vimwiki settings - path and set to markdown mode.
vim.g.vimwiki_list = {
    {
        path = "C:\\Users\\rp\\vimwiki",
        syntax = "markdown",
        ext = ".wiki"
    }
}

-- Remove trailing spaces before save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*"},
  command = "%s/\\s\\+$//e",
})
