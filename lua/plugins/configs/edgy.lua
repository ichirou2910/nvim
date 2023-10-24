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
            pinned = true,
            open = "Git",
        },
        {
            title = " NOTES",
            ft = "notes",
            pinned = true,
            open = "Note",
        },
        {
            title = " FILE",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            pinned = true,
            size = { height = 0.5 },
            open = "Neotree position=right filesystem",
        },
        {
            title = " BUFFERS",
            ft = "neo-tree",
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "buffers"
            end,
            pinned = true,
            open = "Neotree position=top buffers",
        },
    },
    bottom = {
        {
            title = " TERMINAL",
            ft = "toggleterm",
            size = { height = 0.4 },
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
            size = { height = 20 },
            -- only show help buffers
            filter = function(buf)
                return vim.bo[buf].buftype == "help"
            end,
        },
        { title = " SEARCH & REPLACE", ft = "spectre_panel", size = { height = 0.4 } },
    },

    animate = {
        enabled = false,
    },
    exit_when_last = false,
}
