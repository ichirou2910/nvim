local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_layout = require("telescope.actions.layout")
local trouble = require("trouble.providers.telescope")

require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<M-p>"] = action_layout.toggle_preview,
                ["<c-t>"] = trouble.open_with_trouble,
            },
            n = {
                ["<M-p>"] = action_layout.toggle_preview,
                ["<c-t>"] = trouble.open_with_trouble,
            },
        },
        preview = {
            treesitter = false,
        },
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            follow_symlinks = true,
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
        file_browser = {
            hijack_netrw = true,
        },
    },
    pickers = {
        git_commits = {
            mappings = {
                i = {
                    ["<C-p>"] = function(prompt_bufnr)
                        local selected_entry = action_state.get_selected_entry()
                        local value = selected_entry.value
                        actions.close(prompt_bufnr)
                        vim.schedule(function()
                            vim.cmd(("DiffviewOpen %s^!"):format(value))
                        end)
                    end,
                },
            },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("notify")
require("telescope").load_extension("noice")

require("core.utils").highlight_group("telescope")
