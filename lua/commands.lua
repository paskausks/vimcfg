vim.api.nvim_create_user_command("JsonPretty", '%!python -m json.tool', {})
vim.api.nvim_create_user_command("OpenInExplorer", "!explorer %:p:h", {})
vim.api.nvim_create_user_command("CurFileDir", "NvimTreeFindFile", {})
vim.api.nvim_create_user_command("CopyRelativeFilePath", 'let @* = expand("%")', {})
vim.api.nvim_create_user_command("MyTodos", "Rg TODO\\(rp\\)", {})
vim.api.nvim_create_user_command(
    "InsertDateTime",
    function()
        local currentDateTime = os.date("%Y-%m-%d %H:%M:%S")
        vim.api.nvim_put({currentDateTime}, "", true, true)
    end,
    {}
)
