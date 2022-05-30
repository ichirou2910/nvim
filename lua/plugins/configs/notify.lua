require("notify").setup({
    -- Animation style
    -- fade_in_slide_out, slide, static, fade
    stages = "slide",

    -- Function called when a new window is opened, use for changing win settings/config
    on_open = nil,

    -- Default timeout for notifications
    timeout = 5000,

    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "#2c2e34",

    -- Icons for the different levels
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
})

-- default notification provider
vim.notify = require("notify")
