require("nvim-gps").setup({
    -- separator = "  ",
    separator = "  ",
    -- separator = "  ",
    -- separator = " > ",
    icons = {
        ["class-name"] = " ", -- Classes and class-like objects
        ["function-name"] = " ", -- Functions
        ["method-name"] = " ", -- Methods (functions inside class-like objects)
        ["container-name"] = " ", -- Containers (example: lua tables)
        ["tag-name"] = "炙", -- Tags (example: html tags)
        ["array-name"] = " ",
        ["object-name"] = " ",
        ["null-name"] = "N ",
        ["boolean-name"] = "? ",
        ["number-name"] = "# ",
        ["string-name"] = " ",
    },
})
