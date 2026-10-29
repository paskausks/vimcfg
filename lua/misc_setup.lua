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

-- Surround options (decimals equal to ASCII codes and '\r' is the text to be
-- surrounded)
vim.g.surround_40 = "(\r)"
vim.g.surround_91 = "[\r]"

-- add branch name to status line
vim.opt.statusline = "%{FugitiveStatusline()} " .. vim.opt.statusline:get()

require("fzf-lua").setup({
    file_ignore_patterns = require("file_ignore_patterns"),
})

require("aerial").setup({
    open_automatic = false,
    ignore = {
        filetypes = { "markdown", "gitcommit" },
    },
    layout = {
        default_direction = "left",
        min_width = 40,
    },
})

require("bufferline").setup({
  options = {
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

require('gitsigns').setup{
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        vim.keymap.set('n', '<space>rv', gitsigns.preview_hunk)
        vim.keymap.set('n', '<space>rs', gitsigns.reset_hunk)
    end
}

require('nvim-treesitter').install { 'gdscript', 'odin' }
