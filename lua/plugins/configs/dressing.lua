require("dressing").setup({
    input = {
        relative = "cursor",
        winblend = 10,
        insert_only = false,
        border = "rounded",
        winhighlight = "NormalFloat:PreviewFloat,FloatBorder:PreviewBorder",
    },
    select = {
        backend = { "telescope", "fzf", "builtin" },
    },
})
