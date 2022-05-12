local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(clients)
            -- filter out clients that you don't want to use
            return vim.tbl_filter(function(client)
                return client.name ~= "tsserver"
            end, clients)
        end,
        bufnr = bufnr,
    })
end

local function on_attach(client, bufnr)
    local function buf_opt(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_opt("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>", opts)
    vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Formatting
    if client.supports_method("textDocument/formatting") then
        local formatGroup = vim.api.nvim_create_augroup("Format", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format()
            end,
            group = formatGroup,
            pattern = "*",
        })
    end
end

-- some servers need this
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem = {
    documentationFormat = {
        "markdown",
        "plaintext",
    },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = {
        valueSet = { 1 },
    },
    resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    },
}

-- lspconfig stuff
local function setup_servers()
    local lspconfig = require("lspconfig")

    local common_config = {
        capabilities = capabilities,
        on_attach = on_attach,
        debounce_text_changes = 150,
    }

    -- servers with default config
    local servers = { "html", "cssls", "vimls" }

    for _, lsp in pairs(servers) do
        lspconfig[lsp].setup(common_config)
    end

    -- tsserver
    lspconfig.tsserver.setup({
        -- Needed for inlayHints. Merge this table with your settings or copy
        -- it from the source if you want to add your own init_options.
        init_options = require("nvim-lsp-ts-utils").init_options,
        --
        on_attach = function(client, bufnr)
            local ts_utils = require("nvim-lsp-ts-utils")

            -- defaults
            ts_utils.setup({
                enable_import_on_completion = true,
            })

            -- required to fix code action ranges and filter diagnostics
            ts_utils.setup_client(client)

            -- call local on_attach
            on_attach(client, bufnr)
        end,
    })

    -- sumneko_lua
    local sumneko_root_path = "/usr/lib/lua-language-server"
    local sumneko_binary = "/usr/bin/lua-language-server"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.sumneko_lua.setup({
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                runtime = { version = "LuaJIT", path = runtime_path },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
                telemetry = { enable = false },
            },
        },
    })

    -- ccls
    local ccls_config = {
        init_options = {
            cache = { directory = "/tmp/ccls" },
            compilationDatabaseDirectory = "build",
            index = {
                threads = 0,
            },
            clang = {
                excludeArgs = { "-frounding-math" },
            },
        },
    }
    lspconfig.ccls.setup(vim.tbl_extend("force", common_config, ccls_config))

    -- omnisharp
    local pid = vim.fn.getpid()
    local omnisharp_binary = "/usr/bin/omnisharp"
    local omnisharp_config = {
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_binary, "--languageserver", "--hostPID", tostring(pid) },
        root_dir = lspconfig.util.root_pattern("*.csproj", "*.sln"),
    }
    require("lspconfig").omnisharp.setup(vim.tbl_extend("keep", common_config, omnisharp_config))

    -- null-ls
    require("plugins.configs.null-ls").setup(on_attach)
end

setup_servers()

-- replace the default lsp diagnostic letters with prettier symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = false, signs = true, underline = true }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- vim.api.nvim_command([[
--         autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false, border = "rounded"})
--     ]])

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

    -- Show the popup diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
        vim.w.lsp_diagnostics_last_cursor = current_cursor
        vim.diagnostic.open_float(0, { scope = "cursor", focusable = false, border = "rounded" }) -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
    end
end

vim.cmd([[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]])
