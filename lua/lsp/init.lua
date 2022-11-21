local lspconfig = require("lspconfig")
local lsp_utils = require("lsp.utils")
local lsp_path = lspconfig.util.path

local common_config = {
    capabilities = lsp_utils.get_capabilities(),
    on_attach = lsp_utils.lsp_attach,
    debounce_text_changes = 150,
}

-- servers with default config
local servers = { "html", "cssls" }

for _, s in pairs(servers) do
    lspconfig[s].setup(common_config)
end

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

-- sumneko_lua
local function lsp_sumneko_lua()
    local root_path = "/usr/lib/lua-language-server"
    local binary = "/usr/bin/lua-language-server"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    lspconfig.sumneko_lua.setup({
        cmd = { binary, "-E", root_path .. "/main.lua" },
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        flags = { debounce_text_changes = 150 },
        settings = {
            Lua = {
                format = {
                    enable = false,
                },
                diagnostics = { globals = { "vim" } },
                hint = {
                    enable = true,
                    arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                    await = true,
                    paramName = "Disable", -- "All", "Literal", "Disable"
                    paramType = false,
                    semicolon = "Disable", -- "All", "SameLine", "Disable"
                    setType = true,
                },
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

-- omnisharp
local function lsp_omnisharp()
    local pid = vim.fn.getpid()
    local binary = "/usr/bin/omnisharp"
    local config = {
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { binary, "--languageserver", "--hostPID", tostring(pid), "--loglevel", "information" },

        organize_imports_on_format = true,
    }
    lspconfig.omnisharp.setup(vim.tbl_extend("force", common_config, config))
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

    require("lspconfig").pyright.setup({
        on_init = function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        end,
    })
    lspconfig.pyright.setup(vim.tbl_extend("keep", common_config, config))
end

lsp_tsserver()
lsp_sumneko_lua()
lsp_ccls()
lsp_omnisharp()
lsp_pyright()

-- null-ls
require("plugins.configs.null-ls").setup()

require("core.utils").highlight_group("lsp")
