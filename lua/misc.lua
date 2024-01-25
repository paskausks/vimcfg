-- use snipmate snippets with luasnip
require("luasnip.loaders.from_snipmate").lazy_load()

-- Surround options (decimals equal to ASCII codes and '\r' is the text to be
-- surrounded)
vim.g.surround_40 = "(\r)"
vim.g.surround_91 = "[\r]"

-- Remove trailing spaces before save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*"},
  command = "%s/\\s\\+$//e",
})
