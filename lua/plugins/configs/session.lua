local status, auto_session = pcall(require, "auto-session")

if not status then
    return
end

auto_session.setup({
    pre_save_cmds = { "SidebarCloseAll" },
    log_level = "error",
    auto_session_suppress_dirs = { "~/" },
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_create_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = false,
    bypass_session_save_file_types = { "noice", "notify" },
})
