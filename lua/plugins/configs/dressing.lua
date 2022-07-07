require("dressing").setup({
    input = {
        relative = "cursor",
        winblend = 0,
        insert_only = false,
        border = "solid",
    },
    select = {
        backend = { "telescope", "fzf", "builtin" },
    },
})
