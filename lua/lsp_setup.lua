-- when in doubt - "help lsp"

local function setup()
    -- cmp/autocomplete setup
    -- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
    vim.opt.completeopt = { "menuone", "noselect", "popup" } 
    vim.opt.pumborder = "rounded"
    vim.opt.complete:append('o')
    vim.opt.autocomplete = true

    -- sign column (gutter) icons
    local round_ico = "󱓻"
    local signs = {}
    local numhl = {}
    for _, name in ipairs({ "Error", "Warn", "Hint", "Info" }) do
        local hl = "DiagnosticSign" .. name
        signs[vim.diagnostic.severity[name:upper()]] = round_ico
        numhl[vim.diagnostic.severity[name:upper()]] = hl
    end
    vim.diagnostic.config({ signs = { text = signs, numhl = numhl } })

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- the default shortcuts don't show the floating window, so we add an override
    vim.keymap.set("n", "[d", function () vim.diagnostic.jump({ count=-1, float=true }) end)
    vim.keymap.set("n", "]d", function () vim.diagnostic.jump({ count=1, float=true }) end)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable manual completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })


    -- BEGIN AUTOCOMPLETE SETUP
    -- Autocompletion is expensive. In order to provide completion, text must be synchronized on each completion request,
    -- and autocompletion plugins often send multiple completion requests per second to the language server as you type.
    -- If you notice slowdowns, the most likely candidate is your autocompletion plugin, or the language server which
    -- is bottlenecking it.

    -- Enable some language servers with the additional completion capabilities offered by blink.cmp
    local servers = { "ts_ls", "eslint", "rust_analyzer", "clangd", "ols"}
    for _, lsp in ipairs(servers) do
      vim.lsp.enable(lsp)
    end

    vim.lsp.config["gdscript"] = {
        --capabilities = capabilities,
        -- requires netcat
        -- for windows, get "ncat" (https://nmap.org/ncat/)
        -- and alias ncat to nc
        cmd = { "nc", "localhost", "6005" }
    }

    vim.lsp.enable("gdscript")
end

return setup
