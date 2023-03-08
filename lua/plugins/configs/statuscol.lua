local ok, statuscol = pcall(require, "statuscol")

if not ok then
    return
end

local builtin = require("statuscol.builtin")
local cfg = {
    -- Builtin 'statuscolumn' options
    setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
    ft_ignore = nil, -- lua table with filetypes for which 'statuscolumn' will be unset
    -- Default segments (fold -> sign -> line number + separator)
    segments = {
        {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
    },
    clickhandlers = {
        Lnum = builtin.lnum_click,
        FoldClose = builtin.foldclose_click,
        FoldOpen = builtin.foldopen_click,
        FoldOther = builtin.foldother_click,
        DapBreakpointRejected = builtin.toggle_breakpoint,
        DapBreakpoint = builtin.toggle_breakpoint,
        DapBreakpointCondition = builtin.toggle_breakpoint,
        DiagnosticSignError = builtin.diagnostic_click,
        DiagnosticSignHint = builtin.diagnostic_click,
        DiagnosticSignInfo = builtin.diagnostic_click,
        DiagnosticSignWarn = builtin.diagnostic_click,
        GitSignsTopdelete = builtin.gitsigns_click,
        GitSignsUntracked = builtin.gitsigns_click,
        GitSignsAdd = builtin.gitsigns_click,
        GitSignsChangedelete = builtin.gitsigns_click,
        GitSignsDelete = builtin.gitsigns_click,
    },
}

statuscol.setup(cfg)
