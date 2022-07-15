local dap = require("dap")

-- Setup
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}
vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "DiagnosticWarn",
    linehl = "DapStopped",
    numhl = "",
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DiagnosticError",
    linehl = "",
    numhl = "",
})
vim.fn.sign_define("DapLogPoint", {
    text = "",
    texthl = "DiagnosticInfo",
    linehl = "",
    numhl = "",
})

-- Config
-- # Adapters
-- .NET Core
dap.adapters.netcoredbg = function(cb, config)
    if config.preLaunchTask then
        -- vim.api.nvim_command('call VimuxRunCommand("' .. config.preLaunchTask .. '")')
        vim.fn.system(config.preLaunchTask)
    end
    local adapter = {
        type = "executable",
        command = "/usr/bin/netcoredbg",
        args = { "--interpreter=vscode" },
    }
    cb(adapter)
end

-- # Configuration
dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}

-- C# configuration
dap.configurations.cs = (function()
    local fd = vim.loop.fs_open(vim.fn.getcwd() .. "/.vim/dap.json", "r", 438)
    local dap_config = {}
    if fd then
        local stat = vim.loop.fs_fstat(fd)
        local config_string = vim.loop.fs_read(fd, stat.size, 0)
        local dap_data = vim.fn.json_decode(config_string)["config"]
        local cwd = vim.fn.getcwd()
        for _, data in pairs(dap_data) do
            local config = {
                type = "netcoredbg",
                name = data["name"],
                request = "launch",
                preLaunchTask = "dotnet build",
                cwd = cwd .. "/" .. data["cwd"],
                program = cwd .. "/" .. data["program"],
                env = {
                    ASPNETCORE_ENVIRONMENT = "Development",
                },
            }
            table.insert(dap_config, config)
        end
    else
        table.insert(dap_config, {
            type = "netcoredbg",
            name = "launch - netcoredbg",
            request = "launch",
            cwd = vim.fn.getcwd(),
            program = function()
                return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
            processId = function()
                local pid = require("dap.utils").pick_process()
                vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
                return pid
            end,
        })
    end
    table.insert(dap_config, {
        type = "netcoredbg",
        name = "attach - netcoredbg",
        request = "attach",
        processId = function()
            local pid = require("dap.utils").pick_process()
            vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
            return pid
        end,
    })
    return dap_config
end)()

dap.configurations.c = dap.configurations.cpp

require("core.utils").highlight_group("dap")
