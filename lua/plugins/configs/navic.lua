local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
    return
end

local icons = require("core.ui.icons")

navic.setup({
    icons = {
        File = icons.kind.File,
        Module = icons.kind.Module,
        Namespace = icons.kind.Namespace,
        Package = icons.type.Package,
        Class = icons.kind.Class,
        Method = icons.kind.Method,
        Property = icons.kind.Property,
        Field = icons.kind.Field,
        Constructor = icons.kind.Constructor,
        Enum = icons.kind.Enum,
        Interface = icons.kind.Interface,
        Function = icons.kind.Function,
        Variable = icons.kind.Variable,
        Constant = icons.kind.Constant,
        String = icons.type.String,
        Number = icons.type.Number,
        Boolean = icons.type.Boolean,
        Array = icons.type.Array,
        Object = icons.type.Object,
        Key = icons.kind.Keyword,
        Null = icons.type.Number,
        EnumMember = icons.kind.EnumMember,
        Struct = icons.kind.Struct,
        Event = icons.kind.Event,
        Operator = icons.kind.Operator,
        TypeParameter = icons.kind.TypeParameter,
    },
    separator = " " .. icons.ui.ChevronRight .. " ",
    highlight = true,
    depth_limit = 0,
    depth_limit_indicator = "..",
})

vim.g.navic_silence = true

require("core.utils").highlight_group("navic")
