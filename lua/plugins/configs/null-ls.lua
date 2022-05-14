local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local lsp_utils = require("lsp.utils")

local builtins = null_ls.builtins

local sources = {
    -- Diagnostics
    builtins.diagnostics.eslint_d,
    builtins.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    -- Format
    builtins.formatting.prettierd.with({ filetypes = { "html", "json", "markdown", "scss", "css" } }),
    builtins.formatting.shfmt,
    builtins.formatting.stylua,

    -- Code actions
    builtins.code_actions.eslint_d,
}

local M = {}
M.setup = function()
    null_ls.setup({ sources = sources, on_attach = lsp_utils.lsp_attach, debounce = 150 })
end

return M
