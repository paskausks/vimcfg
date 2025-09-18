local function setup()
    -- sign column (gutter) icons
    local round_ico = "󱓻"
    local signs = { Error = round_ico, Warn = round_ico, Hint = round_ico, Info = round_ico }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[g", function () vim.diagnostic.jump({ count=-1, float=true }) end)
    vim.keymap.set("n", "]g", function () vim.diagnostic.jump({ count=1, float=true }) end)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts) -- use treesitter-refactor
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
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

    -- Add additional capabilities supported by blink.cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Enable some language servers with the additional completion capabilities offered by blink.cmp
    local servers = { "ts_ls", "eslint", "rust_analyzer", "clangd", "csharp_ls", "gopls", "pylsp"}
    for _, lsp in ipairs(servers) do
      vim.lsp.config[lsp] = {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
      }
      vim.lsp.enable(lsp)
    end

    vim.lsp.config["gdscript"] = {
        capabilities = capabilities,
        -- requires netcat
        -- for windows, get "ncat" (https://nmap.org/ncat/)
        -- and alias ncat to nc
        cmd = { "nc", "localhost", "6005" }
    }

    vim.lsp.enable("gdscript")
end

return setup
