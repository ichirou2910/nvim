local status_ok, signature = pcall(require, "lsp_signature")

if not status_ok then
    return
end

signature.setup({
    bind = true,
    handler_opts = { border = "rounded" },
    max_width = 120,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    always_trigger = false,
    floating_window_above_cur_line = true,
    trigger_on_newline = false,
    zindex = 50,
})
