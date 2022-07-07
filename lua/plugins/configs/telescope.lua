local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

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
            },
            n = {
                ["<M-p>"] = action_layout.toggle_preview,
            },
        },
        preview = {
            treesitter = false,
            mime_hook = function(filepath, bufnr, opts)
                local is_image = function(file)
                    local image_extensions = { "png", "jpg" } -- Supported image formats
                    local split_path = vim.split(file:lower(), ".", { plain = true })
                    local extension = split_path[#split_path]
                    return vim.tbl_contains(image_extensions, extension)
                end
                if is_image(filepath) then
                    local term = vim.api.nvim_open_term(bufnr, {})
                    local function send_output(_, data, _)
                        for _, d in ipairs(data) do
                            vim.api.nvim_chan_send(term, d .. "\r\n")
                        end
                    end
                    vim.fn.jobstart({
                        "catimg",
                        filepath, -- Terminal image viewer command
                    }, { on_stdout = send_output, stdout_buffered = true })
                else
                    require("telescope.previewers.utils").set_preview_message(
                        bufnr,
                        opts.winid,
                        "Binary cannot be previewed"
                    )
                end
            end,
        },
    },
    -- pickers = {
    --     buffers = {
    --         theme = "dropdown",
    --     },
    --     find_files = {
    --         theme = "dropdown",
    --     },
    --     lsp_code_actions = {
    --         theme = "cursor",
    --     },
    --     lsp_range_code_actions = {
    --         theme = "cursor",
    --     },
    --     commands = {
    --         theme = "ivy",
    --     },
    --     live_grep = {
    --         layout_strategy = "horizontal",
    --         layout_config = {
    --             preview_width = 0.4,
    --         },
    --     },
    -- },
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
require("telescope").load_extension("notify")
