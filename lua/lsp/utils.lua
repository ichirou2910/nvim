local utils = require("core.utils")

local M = {}

function M.lsp_diagnostics()
    vim.diagnostic.config({
        virtual_text = {
            source = "always",
            prefix = "■",
            -- Only show virtual text matching the given severity
            severity = {
                -- Specify a range of severities
                min = vim.diagnostic.severity.ERROR,
            },
        },
        float = {
            source = "always",
            border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

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

    local lspHoverDiagnostic = vim.api.nvim_create_augroup("LspHoverDiagnostic", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        group = lspHoverDiagnostic,
        callback = function()
            _G.LspDiagnosticsPopupHandler()
        end,
        pattern = "*",
    })
end

function M.lsp_highlight(client, bufnr)
    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })

    if client.supports_method("textDocument/documentHighlight") then
        vim.cmd(
            [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#282f45
        hi LspReferenceText cterm=bold ctermbg=red guibg=#282f45
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#282f45
        ]],
            false
        )

        local lspDocumentHighligh = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = lspDocumentHighligh,
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = lspDocumentHighligh,
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
        })
    end
end

function M.lsp_config(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>", opts)
    vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>", opts)

    _G.LspPeekDefinition = function()
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
            if result == nil or vim.tbl_isempty(result) then
                return nil
            end

            print(utils.toString(result[1]))
            vim.lsp.util.preview_location(result[1], { border = "rounded" })
        end)
    end

    -- Set some keybinds conditional on server capabilities
    if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end
    if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
    vim.keymap.set("n", "<space>lp", "<cmd>lua _G.LspPeekDefinition()<CR>", opts)

    -- Formatting
    if client.supports_method("textDocument/formatting") then
        local formatGroup = vim.api.nvim_create_augroup("Format", { clear = false })
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format()
            end,
            buffer = bufnr,
            group = formatGroup,
        })
    end
end

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- for nvim-cmp
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    capabilities.textDocument.codeAction = {
        dynamicRegistration = true,
        codeActionLiteralSupport = {
            codeActionKind = {
                valueSet = (function()
                    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                    table.sort(res)
                    return res
                end)(),
            },
        },
    }

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
end

function M.lsp_attach(client, bufnr)
    M.lsp_config(client, bufnr)
    M.lsp_highlight(client, bufnr)
    M.lsp_diagnostics()
end

return M
