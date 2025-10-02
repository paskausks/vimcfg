vim.api.nvim_create_user_command("JsonPretty", '%!python3 -m json.tool', {})
vim.api.nvim_create_user_command("Whitespace", "%s/\\s\\+$//e", {})
vim.api.nvim_create_user_command(
    "InsertDateTime",
    function()
        local currentDateTime = os.date("%Y-%m-%d %H:%M:%S")
        vim.api.nvim_put({currentDateTime}, "", true, true)
    end,
    {}
)

vim.api.nvim_create_user_command("BufOnly", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { })
    end
  end
  vim.cmd("edit")  -- refresh buffer tab line
end, {})
