local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local lsp_utils = require("lsp.utils")

local builtins = null_ls.builtins
local command_resolver = require("null-ls.helpers.command_resolver")

local sources = {
    -- Diagnostics
    builtins.diagnostics.eslint_d,
    builtins.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    -- Format
    builtins.formatting.prettierd.with({
        filetypes = { "html", "json", "markdown", "scss", "css" },
        dynamic_command = command_resolver.from_node_modules(),
    }),
    builtins.formatting.shfmt,
    builtins.formatting.stylua,

    -- Code actions
    builtins.code_actions.eslint_d,
    builtins.code_actions.shellcheck,
}

local M = {}
M.setup = function()
    null_ls.setup({ sources = sources, on_attach = lsp_utils.lsp_attach, debounce = 150 })
end

return M
