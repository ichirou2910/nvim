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

        -- Telescope borderless
        local prompt = "#2F334D"
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
            bg = c.red,
            fg = c.bg,
        }
        hl.TelescopePreviewTitle = {
            bg = c.blue,
            fg = c.bg,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }

        -- nvim-navic
        hl.NavicIconsFile.bg = c.bg_statusline
        hl.NavicIconsModule.bg = c.bg_statusline
        hl.NavicIconsNamespace.bg = c.bg_statusline
        hl.NavicIconsPackage.bg = c.bg_statusline
        hl.NavicIconsClass.bg = c.bg_statusline
        hl.NavicIconsMethod.bg = c.bg_statusline
        hl.NavicIconsProperty.bg = c.bg_statusline
        hl.NavicIconsField.bg = c.bg_statusline
        hl.NavicIconsConstructor.bg = c.bg_statusline
        hl.NavicIconsEnum.bg = c.bg_statusline
        hl.NavicIconsInterface.bg = c.bg_statusline
        hl.NavicIconsFunction.bg = c.bg_statusline
        hl.NavicIconsVariable.bg = c.bg_statusline
        hl.NavicIconsConstant.bg = c.bg_statusline
        hl.NavicIconsString.bg = c.bg_statusline
        hl.NavicIconsNumber.bg = c.bg_statusline
        hl.NavicIconsBoolean.bg = c.bg_statusline
        hl.NavicIconsArray.bg = c.bg_statusline
        hl.NavicIconsObject.bg = c.bg_statusline
        hl.NavicIconsKey.bg = c.bg_statusline
        hl.NavicIconsNull.bg = c.bg_statusline
        hl.NavicIconsEnumMember.bg = c.bg_statusline
        hl.NavicIconsStruct.bg = c.bg_statusline
        hl.NavicIconsEvent.bg = c.bg_statusline
        hl.NavicIconsOperator.bg = c.bg_statusline
        hl.NavicIconsTypeParameter.bg = c.bg_statusline
        hl.NavicText.bg = c.bg_statusline
        hl.NavicSeparator.bg = c.bg_statusline
    end,
})
vim.cmd([[colorscheme tokyonight-moon]])

-- Vender custom theme

require("core.utils").highlight_group("general")
