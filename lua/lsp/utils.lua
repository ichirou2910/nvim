local navic = require("nvim-navic")

local M = {}

local border = require("core.utils").custom_border

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.lsp_diagnostics()
    vim.diagnostic.config({
        virtual_text = false,
        float = {
            source = "always",
            border = border(),
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })

    -- Show diagnostics in a pop-up window on hover
    --[[ _G.LspDiagnosticsPopupHandler = function() ]]
    --[[     local current_cursor = vim.api.nvim_win_get_cursor(0) ]]
    --[[     local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil } ]]
    --[[]]
    --[[     -- Show the popup diagnostics window, ]]
    --[[     -- but only once for the current cursor location (unless moved afterwards). ]]
    --[[     if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then ]]
    --[[         vim.w.lsp_diagnostics_last_cursor = current_cursor ]]
    --[[         vim.diagnostic.open_float({ ]]
    --[[             scope = "cursor", ]]
    --[[             focusable = false, ]]
    --[[             border = border(), ]]
    --[[         }) ]]
    --[[     end ]]
    --[[ end ]]
    --[[]]
    --[[ local lspHoverDiagnostic = vim.api.nvim_create_augroup("LspHoverDiagnostic", { clear = true }) ]]
    --[[ vim.api.nvim_create_autocmd("CursorHold", { ]]
    --[[     group = lspHoverDiagnostic, ]]
    --[[     callback = function() ]]
    --[[         _G.LspDiagnosticsPopupHandler() ]]
    --[[     end, ]]
    --[[     pattern = "*", ]]
    --[[ }) ]]

    vim.keymap.set("n", "<leader>lk", function()
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            border = border(),
        })
    end, { noremap = true, silent = true })
    vim.keymap.set(
        "n",
        "gn",
        "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>",
        { noremap = true, silent = true }
    )
    vim.keymap.set(
        "n",
        "gp",
        "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>",
        { noremap = true, silent = true }
    )
end

function M.lsp_highlight()
    vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticHint" })
end

function M.lsp_config(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end, { noremap = true, silent = true })

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
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })

        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

function M.lsp_inlayHints(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end
end

function M.get_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.textDocument.completion.completionItem.documentationFormat = {
        "markdown",
        "plaintext",
    }
    return capabilities
end

function M.lsp_attach(client, bufnr)
    M.lsp_config(client, bufnr)
    M.lsp_formatting(client, bufnr)
    M.lsp_inlayHints(client, bufnr)
    M.lsp_highlight()
    M.lsp_diagnostics()

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

return M
