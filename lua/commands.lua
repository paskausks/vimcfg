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
