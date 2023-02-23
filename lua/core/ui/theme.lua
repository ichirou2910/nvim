-- Activate highlighting
vim.api.nvim_command("syntax on")
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

-- Available themes, set blank to disable highlight system
vim.g.nv_theme = ""

require("tokyonight").setup({
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    on_highlights = function(hl, c)
        hl.FloatBorder = {
            fg = c.bg_float,
            bg = c.bg,
        }
        hl.NormalFloat = {
            bg = c.bg_float,
        }
        hl.NnnNormal = { bg = c.bg_float }
        hl.NnnBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyERRORBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyWARNBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyINFOBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyDEBUGBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyTRACEBorder = { fg = c.bg_float, bg = c.bg }
        hl.NotifyERRORBody = { bg = c.bg_float }
        hl.NotifyWARNBody = { bg = c.bg_float }
        hl.NotifyINFOBody = { bg = c.bg_float }
        hl.NotifyDEBUGBody = { bg = c.bg_float }
        hl.NotifyTRACEBody = { bg = c.bg_float }
        hl.FoldColumn = { fg = c.fg, bg = nil }

        -- Telescope borderless
        local prompt = "#292e42"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
})
vim.cmd([[colorscheme tokyonight-moon]])

-- Vender custom theme

require("core.utils").highlight_group("general")
