local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_utils = require("lsp.utils")
local lsp_path = lspconfig.util.path

local common_config = {
    capabilities = lsp_utils.get_capabilities(),
    on_attach = lsp_utils.lsp_attach,
    debounce_text_changes = 150,
}

-- servers with default config
local default_servers = { "html", "cssls", "gdscript" }

for _, s in pairs(default_servers) do
    lspconfig[s].setup(common_config)
end

-- servers handled by mason
local mason_servers = {
    lua_ls = {
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        flags = { debounce_text_changes = 150 },
        single_file_support = true,
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    workspaceWord = true,
                    callSnippet = "Both",
                },
                misc = {
                    parameters = {
                        "--log-level=trace",
                    },
                },
                diagnostics = {
                    -- enable = false,
                    groupSeverity = {
                        strong = "Warning",
                        strict = "Warning",
                    },
                    groupFileStatus = {
                        ["ambiguity"] = "Opened",
                        ["await"] = "Opened",
                        ["codestyle"] = "None",
                        ["duplicate"] = "Opened",
                        ["global"] = "Opened",
                        ["luadoc"] = "Opened",
                        ["redefined"] = "Opened",
                        ["strict"] = "Opened",
                        ["strong"] = "Opened",
                        ["type-check"] = "Opened",
                        ["unbalanced"] = "Opened",
                        ["unused"] = "Opened",
                    },
                    unusedLocalExclude = { "_*" },
                },
                hint = {
                    enable = true,
                    arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                    await = true,
                    paramName = "Disable", -- "All", "Literal", "Disable"
                    paramType = false,
                    semicolon = "Disable", -- "All", "SameLine", "Disable"
                    setType = true,
                },
                format = {
                    enable = false,
                },
            },
        },
    },
    csharp_ls = {
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        handlers = {
            ["textDocument/definition"] = require("csharpls_extended").handler,
        },
    },
}
local mason_server_names = vim.tbl_keys(mason_servers)

mason.setup()
mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
    function(server_name)
        if vim.tbl_contains(mason_server_names, server_name) then
            lspconfig[server_name].setup(mason_servers[server_name])
        end
    end,
})

-- tsserver
local function lsp_tsserver()
    require("typescript-tools").setup({
        on_attach = lsp_utils.lsp_attach,
    })
end

lsp_tsserver()

-- null-ls
require("plugins.configs.null-ls").setup()

require("core.utils").highlight_group("lsp")
