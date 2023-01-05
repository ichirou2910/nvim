local dap = require("dap")
local notify_utils = require("core.utils").notify

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
        command = "/usr/bin/netcoredbg",
        args = { "--interpreter=vscode" },
    })
end

-- C/C++/Rust
dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
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

-- Notification
dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
    local notif_data = notify_utils.get_notif_data("dap", body.progressId)

    local message = notify_utils.format_message(body.message, body.percentage)
    notif_data.notification = vim.notify(message, "info", {
        title = notify_utils.format_title(body.title, session.config.type),
        icon = notify_utils.spinner_frames[1],
        timeout = false,
        hide_from_history = false,
    })

    notif_data.notification.spinner = 1
    notify_utils.update_spinner("dap", body.progressId)
end

dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(session, body)
    local notif_data = notify_utils.get_notif_data("dap", body.progressId)
    notif_data.notification = vim.notify(notify_utils.format_message(body.message, body.percentage), "info", {
        replace = notif_data.notification,
        hide_from_history = false,
    })
end

dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(session, body)
    local notif_data = notify_utils.client_notifs["dap"][body.progressId]
    notif_data.notification =
    vim.notify(body.message and notify_utils.format_message(body.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
    })
    notif_data.spinner = nil
end

-- Load VSCode's launch.json file
require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

require("core.utils").highlight_group("dap")
