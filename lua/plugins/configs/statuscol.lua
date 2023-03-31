local ok, statuscol = pcall(require, "statuscol")

if not ok then
    return
end

local builtin = require("statuscol.builtin")
local cfg = {
    -- Builtin 'statuscolumn' options
    setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
    ft_ignore = {
        "nvim-tree",
        "spectre_panel",
        "toggleterm",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
        "dapui_repl",
        "fugitive",
    },
    -- Default segments (fold -> sign -> line number + separator)
    segments = {
        {
            text = { builtin.lnumfunc, " " },
            condition = { builtin.not_empty, true },
            click = "v:lua.ScLa",
        },
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa", condition = { true, builtin.not_empty, true } },
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

vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
    callback = function(ev)
        if vim.tbl_contains(cfg.ft_ignore, vim.bo.filetype) then
            vim.cmd("setlocal statuscolumn=")
            vim.cmd("set nu&")
            vim.cmd("set rnu&")
        end
    end,
})
