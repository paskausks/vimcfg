local function setup()
    local cmp = require "cmp"
    local lspkind = require "lspkind"
    local luasnip = require "luasnip"

    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup {
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol"
            }),
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
            ["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
        }),
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
        },
    }

    cmp.setup.filetype('vimwiki', {
        enabled = false,
    })

    cmp.setup.filetype('markdown', {
        enabled = false,
    })
end

return setup
