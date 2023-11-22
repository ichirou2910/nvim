-- Activate highlighting
vim.api.nvim_command("syntax on")
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

require("tokyonight").setup({
    style = "night",
    transparent = true,
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
    on_colors = function(c)
        c.bg = "#222436"
    end,
    on_highlights = function(hl, c)
        hl.BufferCurrentSign = { fg = c.blue }
        hl.FloatBorder = { fg = c.bg_float, bg = c.bg }
        hl.NormalFloat = { bg = c.bg_float }
        hl.CmpBorder = { link = "FloatBorder" }
        hl.CmpPmenu = { link = "NormalFloat" }
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
        hl.DapStopped = { bg = "#533d12" }

        -- Noice
        hl.NoicePopupmenu = { bg = c.bg_dark, fg = c.fg_dark }
        hl.NoicePopupmenuBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.NoiceCmdlinePopup = { link = "NoicePopupmenu" }
        hl.NoiceCmdlinePopupTitle = { bg = c.yellow, fg = c.bg_dark }
        hl.NoiceCmdlinePopupBorder = { bg = c.bg_dark, fg = c.bg_dark }

        -- Telescope borderless
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePrompt = { bg = c.bg_dark }
        hl.TelescopePromptPrefix = { bg = c.bg_dark }
        hl.TelescopePromptNormal = { bg = c.bg_dark }
        hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptTitle = { bg = c.purple, fg = c.bg_dark }
        hl.TelescopePreviewTitle = { bg = c.blue, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }

        -- nvim-navic
        hl.NavicIconsFile = { bg = c.bg_dark }
        hl.NavicIconsModule = { bg = c.bg_dark }
        hl.NavicIconsNamespace = { bg = c.bg_dark }
        hl.NavicIconsPackage = { bg = c.bg_dark }
        hl.NavicIconsClass = { bg = c.bg_dark }
        hl.NavicIconsMethod = { bg = c.bg_dark }
        hl.NavicIconsProperty = { bg = c.bg_dark }
        hl.NavicIconsField = { bg = c.bg_dark }
        hl.NavicIconsConstructor = { bg = c.bg_dark }
        hl.NavicIconsEnum = { bg = c.bg_dark }
        hl.NavicIconsInterface = { bg = c.bg_dark }
        hl.NavicIconsFunction = { bg = c.bg_dark }
        hl.NavicIconsVariable = { bg = c.bg_dark }
        hl.NavicIconsConstant = { bg = c.bg_dark }
        hl.NavicIconsString = { bg = c.bg_dark }
        hl.NavicIconsNumber = { bg = c.bg_dark }
        hl.NavicIconsBoolean = { bg = c.bg_dark }
        hl.NavicIconsArray = { bg = c.bg_dark }
        hl.NavicIconsObject = { bg = c.bg_dark }
        hl.NavicIconsKey = { bg = c.bg_dark }
        hl.NavicIconsNull = { bg = c.bg_dark }
        hl.NavicIconsEnumMember = { bg = c.bg_dark }
        hl.NavicIconsStruct = { bg = c.bg_dark }
        hl.NavicIconsEvent = { bg = c.bg_dark }
        hl.NavicIconsOperator = { bg = c.bg_dark }
        hl.NavicIconsTypeParameter = { bg = c.bg_dark }
        hl.NavicText = { bg = c.bg_dark }
        hl.NavicSeparator = { bg = c.bg_dark }

        -- nvim-ts-rainbow2
        hl.TSRainbowRed = { fg = "#ed8796" }
        hl.TSRainbowOrange = { fg = "#f5a97f" }
        hl.TSRainbowYellow = { fg = "#eed49f" }
        hl.TSRainbowGreen = { fg = "#a6da95" }
        hl.TSRainbowCyan = { fg = "#7dc4e4" }
        hl.TSRainbowViolet = { fg = "#c6a0f6" }

        -- incline.nvim
        hl.InclineNormalNC = { fg = c.fg, bg = c.terminal_black }
    end,
})
vim.cmd([[colorscheme tokyonight-night]])

-- Vender custom theme

require("core.utils").highlight_group("general")
