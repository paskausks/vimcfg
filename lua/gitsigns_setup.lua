local function setup()
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

            vim.keymap.set('n', '<space>pr', gitsigns.preview_hunk)
            vim.keymap.set('n', '<space>res', gitsigns.reset_hunk)
        end
    }
end

return setup
