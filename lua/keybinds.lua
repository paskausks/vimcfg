-- Unbind F1
vim.keymap.set("n", "<F1>", ":echo<cr>")
vim.keymap.set("i", "<F1>", "<esc>:echo<cr>i")

-- Buffer nav
local buf_next =  ":bn<cr>"
local buf_prev =  ":bp<cr>"
vim.keymap.set("n", "<C-l>", buf_next, { silent = true })
vim.keymap.set("n", "<C-Right>", buf_next, { silent = true })
vim.keymap.set("n", "<C-h>", buf_prev, { silent = true })
vim.keymap.set("n", "<C-Left>", buf_prev, { silent = true })
vim.keymap.set("n", "<C-x>", ":bd<cr>", { silent = true })

-- file pickers
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { silent = true })
vim.keymap.set("n", "<space>t", "<cmd>Telescope buffers<cr>", { silent = true })
vim.keymap.set("n", "<space>ff", ":NvimTreeOpen<cr>")

-- remove trailing spaces in the current buffer
vim.keymap.set("n", "<Leader>t", ":%s/\\s\\+$//<Cr>")

-- Run code inline
vim.keymap.set("n", "<Leader>ts", ":w !ts-node<cr>")
vim.keymap.set("n", "<Leader>js", ":w !node<cr>")

-- format json (jq '.' on unix-like)
vim.keymap.set("n", "<Leader>jq", ":%!jq .<cr>")

-- Search word under cursor with ripgrep
vim.keymap.set("n", "<Leader>f", ":Rg<cr>")
vim.keymap.set("n", "<space>ff", ":Rg<space>")

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+yg_")
vim.keymap.set("n", "<leader>yy", "\"+yy")

-- Paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")

-- Misc
-- exit insert mode in :terminal via double esc press.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

