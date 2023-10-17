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
local default_servers = { "html", "cssls" }

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
    --[[ omnisharp = { ]]
    --[[     on_attach = lsp_utils.lsp_attach, ]]
    --[[     capabilities = lsp_utils.get_capabilities(), ]]
    --[[     handlers = { ]]
    --[[         ["textDocument/definition"] = require("omnisharp_extended").handler, ]]
    --[[     }, ]]
    --[[     enable_editorconfig_support = true, ]]
    --[[     -- If true, MSBuild project system will only load projects for files that ]]
    --[[     -- were opened in the editor. This setting is useful for big C# codebases ]]
    --[[     -- and allows for faster initialization of code navigation features only ]]
    --[[     -- for projects that are relevant to code that is being edited. With this ]]
    --[[     -- setting enabled OmniSharp may load fewer projects and may thus display ]]
    --[[     -- incomplete reference lists for symbols. ]]
    --[[     enable_ms_build_load_projects_on_demand = false, ]]
    --[[     -- Enables support for roslyn analyzers, code fixes and rulesets. ]]
    --[[     enable_roslyn_analyzers = false, ]]
    --[[     -- Specifies whether 'using' directives should be grouped and sorted during ]]
    --[[     -- document formatting. ]]
    --[[     organize_imports_on_format = true, ]]
    --[[     -- Enables support for showing unimported types and unimported extension ]]
    --[[     -- methods in completion lists. When committed, the appropriate using ]]
    --[[     -- directive will be added at the top of the current file. This option can ]]
    --[[     -- have a negative impact on initial completion responsiveness, ]]
    --[[     -- particularly for the first few completion sessions after opening a ]]
    --[[     -- solution. ]]
    --[[     enable_import_completion = true, ]]
    --[[     -- Specifies whether to include preview versions of the .NET SDK when ]]
    --[[     -- determining which version to use for project loading. ]]
    --[[     sdk_include_prereleases = true, ]]
    --[[     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is ]]
    --[[     -- true ]]
    --[[     analyze_open_documents_only = false, ]]
    --[[ }, ]]
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
        settings = {
            tsserver_format_options = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    })
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

local function lsp_godot()
    local config = {
        --[[ cmd = vim.lsp.rpc.connect("127.0.0.1", port), ]]
    }
    lspconfig.gdscript.setup(vim.tbl_extend("force", common_config, config))
end

lsp_tsserver()
lsp_pyright()
lsp_godot()

-- null-ls
require("plugins.configs.null-ls").setup()

require("core.utils").highlight_group("lsp")
