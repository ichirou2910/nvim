local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = { i = { ["<esc>"] = actions.close } },
        preview = {
            treesitter = false,
        },
    },
    pickers = {
        buffers = {
            theme = "dropdown",
        },
        find_files = {
            theme = "dropdown",
        },
        lsp_code_actions = {
            theme = "cursor",
        },
        lsp_range_code_actions = {
            theme = "cursor",
        },
        commands = {
            theme = "ivy",
        },
        live_grep = {
            layout_strategy = "horizontal",
            layout_config = {
                preview_width = 0.4,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("notify")
