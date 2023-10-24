local dap = require("dap")

-- Setup
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

-- Adapters
-- .NET Core
dap.adapters.netcoredbg = function(cb, config)
    if config.preLaunchTask then
        vim.loop.chdir(config.cwd)
        vim.fn.system(config.preLaunchTask)
        -- Doesn't fire debugger if preLaunchTask failed
        if vim.v.shell_error ~= 0 then
            vim.notify("Pre-launch Task failed.")
            return
        end
    end
    cb({
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = { "--interpreter=vscode" },
    })
end

-- C/C++/Rust
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
}

-- Godot
dap.adapters.godot = {
    type = "server",
    host = "127.0.0.1",
    port = 6006,
}

-- Configuration
-- C/C++
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
dap.configurations.c = dap.configurations.cpp

-- C#
dap.configurations.cs = (function()
    local fd = vim.loop.fs_open(vim.fn.getcwd() .. "/.vim/dap.json", "r", 438)
    local dap_config = {}
    if fd then
        local stat = vim.loop.fs_fstat(fd)
        local config_string = vim.loop.fs_read(fd, stat.size, 0)
        local dap_data = vim.fn.json_decode(config_string)["config"]
        local cwd = vim.fn.getcwd()
        for _, data in pairs(dap_data) do
            local env = {
                ASPNETCORE_ENVIRONMENT = "Development",
            }
            if data["env"] ~= nil then
                env = vim.tbl_extend("force", env, data["env"])
            end
            local config = {
                type = "netcoredbg",
                name = data["name"],
                request = "launch",
                preLaunchTask = "dotnet build",
                cwd = cwd .. "/" .. data["cwd"],
                program = cwd .. "/" .. data["program"],
                env = env,
            }
            table.insert(dap_config, config)
        end
    end
    table.insert(dap_config, {
        type = "netcoredbg",
        name = "Attach",
        request = "attach",
        processId = function()
            local pid = require("dap.utils").pick_process()
            vim.fn.setenv("NETCOREDBG_ATTACH_PID", pid)
            return pid
        end,
    })
    return dap_config
end)()

-- Godot
dap.configurations.gdscript = {
    {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
    },
}

dap.defaults.fallback.switchbuf = "useopen,uselast"

-- Load VSCode's launch.json file
require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

require("core.utils").highlight_group("dap")
