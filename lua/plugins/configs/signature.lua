local present, lspsignature = pcall(require, "lsp_signature")

if present then

    lspsignature.setup {
        bind = true,
        handler_opts = {border = "rounded"},
        hint_enable = false,
        hint_prefix = " ",
        hint_scheme = "String",
        floating_window_above_cur_line = true,
        trigger_on_newline = false,
        zindex = 50
    }

end
