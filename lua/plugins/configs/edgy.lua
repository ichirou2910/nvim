-- Config for edgy.nvim

return {
    options = {
        left = { size = 55 },
    },
    top = {
        {
            title = " GIT COMMIT",
            ft = "gitcommit",
            size = { height = 0.3 },
        },
    },
    left = {
        {
            title = " GIT",
            ft = "fugitive",
            open = "Git",
        },
        {
            title = " NOTES",
            ft = "notes",
            open = "Note",
        },
        {
            title = " FILE",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            size = { height = 0.5 },
            open = "Neotree position=right filesystem",
        },
        {
            title = " DEBUG SCOPE",
            ft = "dapui_scopes",
            size = { height = 0.4 },
            open = "lua require'dapui'.open()",
        },
        {
            title = " DEBUG BREAKPOINTS",
            ft = "dapui_breakpoints",
            size = { height = 0.2 },
            open = "lua require'dapui'.open()",
        },
        {
            title = " DEBUG STACKS",
            ft = "dapui_stacks",
            size = { height = 0.2 },
            open = "lua require'dapui'.open()",
        },
        {
            title = " DEBUG WATCHES",
            ft = "dapui_watches",
            size = { height = 0.2 },
            open = "lua require'dapui'.open()",
        },
    },
    bottom = {
        {
            title = " TERMINAL",
            ft = "toggleterm",
            size = { height = 0.3 },
            -- exclude floating windows
            filter = function(_, win)
                return vim.api.nvim_win_get_config(win).relative == ""
            end,
        },
        { title = "󰁨 TROUBLE", ft = "Trouble" },
        { title = " QUICKFIX", ft = "qf" },
        {
            title = "󰋖 NEOVIM HELP",
            ft = "help",
            size = { height = 0.3 },
            -- only show help buffers
            filter = function(buf)
                return vim.bo[buf].buftype == "help"
            end,
        },
        {
            title = " SEARCH & REPLACE",
            ft = "spectre_panel",
            wo = {
                number = false,
                relativenumber = false,
            },
            size = { height = 0.3 },
        },
        {
            title = " DEBUG REPL",
            ft = "dap-repl",
            wo = { winbar = false, statuscolumn = "" },
            size = { height = 0.3 },
            open = "lua require'dapui'.open()",
        },
    },

    animate = {
        enabled = false,
    },
    exit_when_last = false,
}
