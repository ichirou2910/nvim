-- Theme: Onedarkpro
-- local onedarkpro = require("onedarkpro")

-- onedarkpro.setup({
--     colors = {
--         onedark = {
--             bg = "nil", -- yellow
--         },
--     },
-- })

-- onedarkpro.load()

-- Theme: Tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_colors = {
    -- bg = "#1b1f27",
}
vim.g.tokyonight_sidebars = {
    "qf",
    "packer",
    "notes",
    "fugitive",
    "symbols",
}
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_lualine_bold = false

vim.cmd([[colorscheme tokyonight]])
