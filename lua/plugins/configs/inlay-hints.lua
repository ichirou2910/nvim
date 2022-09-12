local status_ok, hints = pcall(require, "lsp-inlayhints")

if not status_ok then
    return
end

hints.setup({
    inlay_hints = {
        parameter_hints = {
            show = false,
            -- prefix = "<- ",
            separator = ", ",
        },
        type_hints = {
            -- type and other hints
            show = true,
            prefix = "",
            separator = ", ",
            remove_colon_end = false,
            remove_colon_start = false,
        },
        -- separator between types and parameter hints. Note that type hints are
        -- shown before parameter
        labels_separator = "  ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
    },
    debug_mode = false,
})
