local ok, noice = pcall(require, "noice")

if not ok then
    return
end

noice.setup({
    debug = false,
    lsp = {
        hover = {
            enabled = true,
        },
        signature = {
            enabled = true,
        },
        message = {
            enabled = true,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    views = {
        hover = {
            border = {
                style = { "", "", "", "", "", "", "", "" },
                padding = { 0, 0 },
            },
            position = { row = 1, col = 1 },
        },
        popup = {
            border = {
                style = { "", "", "", "", "", "", "", "" },
            },
        },
        popupmenu = {
            border = {
                style = { "", "", "", "", "", "", "", "" },
            },
        },
        cmdline_popup = {
            position = {
                col = "50%",
                row = vim.o.lines / 2 - 9,
            },
            border = {
                style = "solid",
            },
        },
        cmdline_popupmenu = {
            position = {
                col = "50%",
                row = vim.o.lines / 2 - 6,
            },
            size = {
                width = 60,
                height = "auto",
                max_height = 15,
            },
            border = {
                style = "solid",
            },
        },
        split = {
            win_options = {
                winhighlight = { Normal = "Normal" },
            },
        },
    },
    presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        cmdline_output_to_split = false,
    },
    commands = {
        all = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {},
        },
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                kind = "search_count",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
    },
})
