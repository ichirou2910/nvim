local custom_border = require("core.utils").custom_border

require("toggleterm").setup({
    persist_size = false,
    direction = "horizontal",
    float_opts = {
        border = custom_border("ToggletermBorder"),
        winblend = 0,
    },
    highlights = { NormalFloat = { link = "ToggletermFloat" } },
})

require("core.utils").highlight_group("toggleterm")
