-- Env var for godot executable
vim.g.godot_path_env = "GODOT4BETA"

-- args for running godot game
vim.g.godot_args = "--colemak"

-- launch the main scene set for the project in the current working directory (has to have a "project.godot")
vim.keymap.set("n", "<Leader>g", function()
  local godot_path = os.getenv(vim.g.godot_path_env)
  local args = vim.g.godot_args or ""
  vim.cmd("!" .. godot_path .. " " .. args)
end)

-- Remap custom godot extensions
local function map_extensions_to_filetype(exts, filetype)
  for _, ext in ipairs(exts) do
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*." .. ext,
      callback = function()
        vim.bo.filetype = filetype
      end,
    })
  end
end

map_extensions_to_filetype({ "actioncnd", "levelcnd" }, "yaml")
map_extensions_to_filetype({ "wordlist", "synonymlist" }, "csv")
map_extensions_to_filetype({ "csvschema" }, "json")

-- Extract GDScript node reference into a variable.
-- Takes a line like this: "(%SomeNode as SomeType).foo()"
-- and puts a line above it like this "var some_node: SomeType = %SomeNode"
vim.api.nvim_create_user_command("ExtractNodeVar", function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local node, type_ = line:match("%((%%%w+) as ([%w_]+)%)")
  if not node or not type_ then
    print("No match found on this line")
    return
  end

  local var_name = node:sub(2):gsub("(%u)", function(c)
    return "_" .. c:lower()
  end):gsub("^_", "")

  local new_line = string.format("var %s: %s = %s", var_name, type_, node)

  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { new_line })
end, {})
