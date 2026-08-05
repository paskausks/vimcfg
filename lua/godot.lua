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

map_extensions_to_filetype({ "locmeta" }, "yaml")
map_extensions_to_filetype({ "termlist" }, "csv")
map_extensions_to_filetype({ "csvschema" }, "json")
