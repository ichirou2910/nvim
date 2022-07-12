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
    linehl = "",
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
dap.configurations.cs = {
    {
        type = "netcoredbg",
        name = "launch - netcoredbg",
        request = "launch",
        preLaunchTask = "dotnet build",
        cwd = function()
            local cwd = vim.fn.getcwd()
            local config_path = cwd .. "/.vim/dap.json"
            local fd = vim.loop.fs_open(config_path, "r", 438)
            if fd then
                local stat = vim.loop.fs_fstat(fd)
                if stat then
                    local data = vim.loop.fs_read(fd, stat.size, 0)
                    local workspace_path = vim.fn.json_decode(data)["cwd"]
                    if workspace_path ~= nil then
                        return cwd .. "/" .. workspace_path
                    end
                end
            end

            return cwd
        end,
        program = function()
            local cwd = vim.fn.getcwd()
            local config_path = cwd .. "/.vim/dap.json"
            local fd = vim.loop.fs_open(config_path, "r", 438)
            if fd then
                local stat = vim.loop.fs_fstat(fd)
                if stat then
                    local data = vim.loop.fs_read(fd, stat.size, 0)
                    local program_path = vim.fn.json_decode(data)["program"]
                    if program_path ~= nil then
                        return vim.fn.input("Path to dll: ", cwd .. "/" .. program_path, "file")
                    end
                end
            end

            local d = vim.fn.fnamemodify(cwd, ":t")
            return vim.fn.input("Path to dll: ", cwd .. "/bin/Debug/netcoreapp3.1/" .. d .. ".dll", "file")
            -- return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
        env = {
            ASPNETCORE_ENVIRONMENT = "Development",
        },
    },
    {
        type = "netcoredbg",
        name = "attach - netcoredbg",
        request = "attach",
        processId = function()
            local pid = require("dap.utils").pick_process()
            vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
            return pid
        end,
    },
}

dap.configurations.c = dap.configurations.cpp
