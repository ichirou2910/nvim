local utils = require("core.utils")
local navic = require("nvim-navic")

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
    vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
    vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
    vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
    vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
    vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
    vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
    vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
    vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

    -- LSP Progress notification
    vim.lsp.handlers["$/progress"] = function(_, result, ctx)
        local client_id = ctx.client_id
        local client_name = vim.lsp.get_client_by_id(client_id).name

        -- Suppress notification from null-ls
        if client_name == "null-ls" then
            return
        end

        local val = result.value

        if not val.kind then
            return
        end

        local notif_data = utils.notify.get_notif_data(client_id, result.token)

        if val.kind == "begin" then
            local message = utils.notify.format_message(val.message, val.percentage)

            notif_data.notification = vim.notify(message, "info", {
                title = utils.notify.format_title(val.title, client_name),
                icon = utils.notify.spinner_frames[1],
                timeout = false,
                hide_from_history = false,
            })

            notif_data.spinner = 1
            utils.notify.update_spinner(client_id, result.token)
        elseif val.kind == "report" and notif_data then
            notif_data.notification = vim.notify(utils.notify.format_message(val.message, val.percentage), "info", {
                replace = notif_data.notification,
                hide_from_history = false,
            })
        elseif val.kind == "end" and notif_data then
            notif_data.notification =
                vim.notify(val.message and utils.notify.format_message(val.message) or "Complete", "info", {
                    icon = "",
                    replace = notif_data.notification,
                    timeout = 250,
                })

            notif_data.spinner = nil
        end
    end

    -- LSP Message notification
    local lspMsgSeverity = {
        "error",
        "warn",
        "info",
        "info", -- map both hint and info to info?
    }
    vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
        vim.notify(method.message, lspMsgSeverity[params.type])
    end

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
end

function M.lsp_config(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>", opts)
    vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end
    if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Formatting
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_command([[augroup Format]])
        vim.api.nvim_command([[autocmd! * <buffer>]])
        vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
        vim.api.nvim_command([[augroup END]])
    end

    -- Codelens
    if client.supports_method("textDocument/codeLens") then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            callback = vim.lsp.codelens.refresh,
            buffer = bufnr,
        })
    end
end

function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- for nvim-cmp
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    vim.tbl_extend("force", capabilities.textDocument.codeAction, {
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
    })

    vim.tbl_extend("force", capabilities.textDocument.completion.completionItem, {
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
    })

    return capabilities
end

function M.lsp_attach(client, bufnr)
    M.lsp_config(client, bufnr)
    M.lsp_highlight(client, bufnr)
    M.lsp_diagnostics()
    if client.supports_method("textDocument/documentSymbol") then
        navic.attach(client, bufnr)
    end
    require("lsp-inlayhints").on_attach(client, bufnr)
end

return M
