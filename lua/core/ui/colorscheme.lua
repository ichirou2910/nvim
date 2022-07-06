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

-- vim.cmd([[colorscheme tokyonight]])

-- Theme: Kanagawa
-- require("kanagawa").setup({
--     undercurl = true, -- enable undercurls
--     commentStyle = { italic = true },
--     functionStyle = {},
--     keywordStyle = { italic = true },
--     statementStyle = { bold = true },
--     typeStyle = {},
--     variablebuiltinStyle = { italic = true },
--     specialReturn = true, -- special highlight for the return keyword
--     specialException = true, -- special highlight for exception handling keywords
--     transparent = false, -- do not set background color
--     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--     globalStatus = false, -- adjust window separators highlight for laststatus=3
--     colors = {},
--     overrides = {},
-- })
--
-- setup must be called before loading
-- vim.cmd("colorscheme kanagawa")

-- vim.g.nvchad_theme = "radium"
-- vim.api.nvim_command("syntax on")
-- if vim.fn.has("termguicolors") == 1 then
--     vim.o.termguicolors = true
-- end
