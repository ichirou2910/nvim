local status_ok, gps = pcall(require, "nvim-gps")
if not status_ok then
    return
end

local icons = require("core.ui.icons")

gps.setup({
    separator = " " .. icons.ui.ChevronRight .. " ",
    -- icons = {
    --     ["class-name"] = icons.kind.Class, -- Classes and class-like objects
    --     ["function-name"] = icons.kind.Function, -- Functions
    --     ["method-name"] = icons.kind.Method, -- Methods (functions inside class-like objects)
    --     ["container-name"] = icons.type.Object, -- Containers (example: lua tables)
    --     ["tag-name"] = icons.misc.Tag, -- Tags (example: html tags)
    --     ["array-name"] = icons.type.Array,
    --     ["sequence-name"] = icons.type.Array,
    --     ["object-name"] = icons.type.Object,
    --     ["null-name"] = icons.kind.Field,
    --     ["boolean-name"] = icons.type.Boolean,
    --     ["number-name"] = icons.type.Number,
    --     ["string-name"] = icons.kind.Text,
    -- },
    icons = {
        ["class-name"] = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. "", -- Classes and class-like objects
        ["function-name"] = "%#CmpItemKindFunction#" .. icons.kind.Function .. "%*" .. "", -- Functions
        ["method-name"] = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. "", -- Methods (functions inside class-like objects)
        ["container-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. "", -- Containers (example: lua tables)
        ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
        ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. "",
        ["sequence-name"] = "%CmpItemKindProperty#" .. icons.type.Array .. "%*" .. "",
        ["null-name"] = "%CmpItemKindField#" .. icons.kind.Field .. "%*" .. "",
        ["boolean-name"] = "%CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. "",
        ["integer-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. "",
        ["float-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. "",
        ["string-name"] = "%CmpItemKindValue#" .. icons.type.String .. "%*" .. "",
        ["array-name"] = "%CmpItemKindProperty#" .. icons.type.Array .. "%*" .. "",
        ["object-name"] = "%CmpItemKindProperty#" .. icons.type.Object .. "%*" .. "",
        ["number-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. "",
        ["table-name"] = "%CmpItemKindProperty#" .. icons.ui.Table .. "%*" .. "",
        ["date-name"] = "%CmpItemKindValue#" .. icons.ui.Calendar .. "%*" .. "",
        ["date-time-name"] = "%CmpItemKindValue#" .. icons.ui.Table .. "%*" .. "",
        ["inline-table-name"] = "%CmpItemKindProperty#" .. icons.ui.Calendar .. "%*" .. "",
        ["time-name"] = "%CmpItemKindValue#" .. icons.misc.Watch .. "%*" .. "",
        ["module-name"] = "%CmpItemKindModule#" .. icons.kind.Module .. "%*" .. "",
    },
    depth = 0,

    -- indicator used when context is hits depth limit
    depth_limit_indicator = "..",
})
