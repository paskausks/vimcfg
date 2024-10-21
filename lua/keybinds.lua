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
vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
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
vim.keymap.set("n", "<space>rr", ":Rg ")

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+yg_")
vim.keymap.set("n", "<leader>yy", "\"+yy")

-- Paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")

-- Navigate to buffers via <C-1>, <C-2>, etc.
function switch_to_buffer_by_position(position)
  local buffers = vim.api.nvim_list_bufs()
  local listed_buffers = {}
  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(buffer, 'buflisted') then
      table.insert(listed_buffers, buffer)
    end
  end
  if position <= #listed_buffers then
    vim.api.nvim_set_current_buf(listed_buffers[position])
  end
end

for i = 1, 9 do
  vim.keymap.set('n', '<C-' .. i .. '>', ':lua switch_to_buffer_by_position(' .. i .. ')<CR>', { noremap = true, silent = true })
end
vim.keymap.set('n', '<C-0>', ':lua switch_to_buffer_by_position(10)<CR>', { noremap = true, silent = true })

-- Misc
-- exit insert mode in :terminal via double esc press.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
