require("dressing").setup({
    input = {
        relative = "cursor",
        win_options = {
            winblend = 10,
            winhighlight = "NormalFloat:PreviewFloat,FloatBorder:PreviewBorder",
        },
        insert_only = false,
        border = "rounded",
    },
    select = {
        backend = { "telescope", "fzf", "builtin" },
    },
})
