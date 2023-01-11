local navic = require("nvim-navic")

local M = {}

function M.lsp_diagnostics()
    vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = { only_current_line = true },
        float = {
            source = "always",
            border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    -- Show diagnostics in a pop-up window on hover
    _G.LspDiagnosticsPopupHandler = function()
        local current_cursor = vim.api.nvim_win_get_cursor(0)
        local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

        -- Show the popup diagnostics window,
        -- but only once for the current cursor location (unless moved afterwards).
        if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
            vim.w.lsp_diagnostics_last_cursor = current_cursor
            vim.diagnostic.open_float({ scope = "cursor", focusable = false, border = "rounded" }) -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
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

function M.lsp_highlight()
    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })
end

function M.lsp_config(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end, opts)
    vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>", opts)
    vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end

    -- Codelens
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            callback = vim.lsp.codelens.refresh,
            buffer = bufnr,
        })
    end
end

function M.lsp_formatting(client, bufnr)
    -- Formatting
    if client.server_capabilities.documentFormattingProvider then
        --[[ vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr }) ]]
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = "LspFormatting",
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    -- Use csharpier instead of built-in omnisharp
                    filter = function(cl)
                        return cl.name ~= "omnisharp"
                    end,
                    bufnr = bufnr,
                })
            end,
        })
    end
end

function M.get_capabilities()
    -- for nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --[[ local capabilities = vim.lsp.protocol.make_client_capabilities() ]]

    capabilities.textDocument.completion.completionItem.documentationFormat = {
        "markdown",
        "plaintext",
    }
    return capabilities
end

function M.lsp_attach(client, bufnr)
    vim.api.nvim_create_augroup("LspFormatting", { clear = false })

    M.lsp_config(client, bufnr)
    M.lsp_formatting(client, bufnr)
    M.lsp_highlight()
    M.lsp_diagnostics()

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
    require("lsp-inlayhints").on_attach(client, bufnr, false)

    -- Omnisharp's semantic tokens don't work nicely with neovim
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider.legend.tokenModifiers = { "staticSymbol" }
        client.server_capabilities.semanticTokensProvider.legend.tokenTypes = {
            "comment",
            "excludedCode",
            "identifier",
            "keyword",
            "keyword.control",
            "number",
            "operator",
            "operator.overloaded",
            "preprocessorKeyword",
            "string",
            "whitespace",
            "text",
            "staticSymbol",
            "preprocessorText",
            "punctuation",
            "string.verbatim",
            "string.escapeCharacter",
            "class",
            "delegate",
            "enum",
            "interface",
            "module",
            "struct",
            "typeParameter",
            "field",
            "enumMember",
            "constant",
            "local",
            "parameter",
            "method",
            "extensionMethod",
            "property",
            "event",
            "namespace",
            "label",
            "xmlDocComment.attribute",
            "xmlDocComment.attributeQuotes",
            "xmlDocComment.attributeValue",
            "xmlDocComment.cdataSection",
            "xmlDocComment.comment",
            "xmlDocComment.delimiter",
            "xmlDocComment.entityReference",
            "xmlDocComment.name",
            "xmlDocComment.processingInstruction",
            "xmlDocComment.text",
            "xmlLiteral.attribute",
            "xmlLiteral.attributeQuotes",
            "xmlLiteral.attributeValue",
            "xmlLiteral.cdataSection",
            "xmlLiteral.comment",
            "xmlLiteral.delimiter",
            "xmlLiteral.embeddedExpression",
            "xmlLiteral.entityReference",
            "xmlLiteral.name",
            "xmlLiteral.processingInstruction",
            "xmlLiteral.text",
            "regex.comment",
            "regex.characterClass",
            "regex.anchor",
            "regex.quantifier",
            "regex.grouping",
            "regex.alternation",
            "regex.text",
            "regex.selfEscapedCharacter",
            "regex.otherEscape",
        }
    end
end

return M
