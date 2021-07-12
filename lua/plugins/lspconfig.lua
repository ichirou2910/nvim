local M = {}

M.config = function()
    local function on_attach(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = {noremap = true, silent = true}

        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

        -- Set some keybinds conditional on server capabilities
        if client.resolved_capabilities.document_formatting then
            buf_set_keymap("n", "<space>lf",
                           "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        elseif client.resolved_capabilities.document_range_formatting then
            buf_set_keymap("n", "<space>lf",
                           "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
        end
        -- formatting
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_command [[augroup Format]]
            vim.api.nvim_command [[autocmd! * <buffer>]]
            vim.api
                .nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
            vim.api.nvim_command [[augroup END]]
        end

        -- completion
        require'completion'.on_attach(client, bufnr)

        -- protocol.SymbolKind = { }
        local protocol = require 'vim.lsp.protocol'

        protocol.CompletionItemKind = {
            '', -- Text
            '', -- Method
            '', -- Function
            '', -- Constructor
            '', -- Field
            '', -- Variable
            '', -- Class
            'ﰮ', -- Interface
            '', -- Module
            '', -- Property
            '', -- Unit
            '', -- Value
            '', -- Enum
            '', -- Keyword
            '', -- Snippet
            '', -- Color
            '', -- File
            '', -- Reference
            '', -- Folder
            '', -- EnumMember
            '', -- Constant
            '', -- Struct
            '', -- Event
            'op', -- Operator
            '' -- TypeParameter
        }
    end

    -- some servers need this
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- lspInstall + lspconfig stuff

    local function setup_servers()
        require"lspinstall".setup()

        local lspconf = require("lspconfig")
        local servers = require"lspinstall".installed_servers()

        for _, lang in pairs(servers) do
            if lang == "efm" then
                local config = {
                    capabilities = capabilities,
                    on_attach = on_attach
                }
                config = vim.tbl_extend("force", config, require 'lsp.efm')
                lspconf[lang].setup(config)
            elseif lang == "lua" then
                lspconf[lang].setup {
                    root_dir = vim.loop.cwd,
                    settings = {
                        Lua = {
                            diagnostics = {globals = {"vim"}},
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                                },
                                maxPreload = 100000,
                                preloadFileSize = 10000
                            },
                            telemetry = {enable = false}
                        }
                    }
                }
            else
                lspconf[lang].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    root_dir = vim.loop.cwd
                }
            end
        end
    end

    setup_servers()

    -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
    require"lspinstall".post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
    end

    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("LspDiagnosticsSignError",
                       {text = "??", numhl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning",
                       {text = "!!", numhl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {
        text = "i>",
        numhl = "LspDiagnosticsDefaultInformation"
    })
    vim.fn.sign_define("LspDiagnosticsSignHint",
                       {text = "?>", numhl = "LspDiagnosticsDefaultHint"})

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                     {virtual_text = false, signs = true, underline = true})

    vim.api.nvim_command(
        [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]])
end

return M
