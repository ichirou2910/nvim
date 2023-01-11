local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local lsp_utils = require("lsp.utils")
local lsp_path = lspconfig.util.path

local common_config = {
    capabilities = lsp_utils.get_capabilities(),
    on_attach = lsp_utils.lsp_attach,
    debounce_text_changes = 150,
}

-- servers with default config
local default_servers = { "html", "cssls" }

for _, s in pairs(default_servers) do
    lspconfig[s].setup(common_config)
end

-- servers handled by mason
local mason_servers = {
    sumneko_lua = {
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
    omnisharp = {
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },

        organize_imports_on_format = true,
    },
}

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(mason_servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(vim.tbl_extend("force", common_config, mason_servers[server_name]))
    end,
})

-- manually handled servers
-- tsserver
local function lsp_tsserver()
    require("typescript").setup({
        server = {
            on_attach = lsp_utils.lsp_attach,
        },
        inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
        },
    })
end

-- ccls
local function lsp_ccls()
    local config = {
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
    lspconfig.ccls.setup(vim.tbl_extend("force", common_config, config))
end

-- pyright
local function lsp_pyright()
    local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
            return lsp_path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        end

        -- Find and use virtualenv from pipenv in workspace directory.
        local match = vim.fn.glob(lsp_path.join(workspace, "Pipfile"))
        if match ~= "" then
            local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
            return lsp_path.join(venv, "bin", "python")
        end

        -- Fallback to system Python.
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    local config = {
        on_init = function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        end,
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        settings = {
            {
                python = {
                    analysis = {
                        typeCheckingMode = "off",
                    },
                },
            },
        },
    }

    lspconfig.pyright.setup(vim.tbl_extend("keep", common_config, config))
end

lsp_tsserver()
lsp_ccls()
lsp_pyright()

-- null-ls
require("plugins.configs.null-ls").setup()

require("core.utils").highlight_group("lsp")
