local filter_bufname = {
    "project-notes.notes",
    "[dap-repl]",
}

vim.cmd("source ~/.config/nvim/configs/bbye.vim")

require("bufferline").setup({
    options = {
        diagnostics_indicator = function(count, _, _, _)
            return tostring(count)
        end,
        custom_filter = function(bufnr)
            if vim.tbl_contains(filter_bufname, vim.fn.bufname(bufnr)) then
                return false
            end
            if vim.regex("^fugitive:///"):match_str(vim.fn.bufname(bufnr)) then
                return false
            end
            return true
        end,
        diagnostics = "nvim_lsp",
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
            -- { filetype = "fugitive", text = "Git", text_align = "center" },
            { filetype = "notes", text = "Notes", text_align = "center" },
            { filetype = "Outline", text = "Outline", text_align = "center" },
            { filetype = "dbui", text = "Database", text_align = "center" },
        },
        -- separator_style = "slant",
    },
    highlights = {
        buffer_selected = {
            gui = "bold",
        },
        diagnostic_selected = {
            gui = "bold",
        },
        info_selected = {
            gui = "bold",
        },
        info_diagnostic_selected = {
            gui = "bold",
        },
        hint_selected = {
            gui = "bold",
        },
        hint_diagnostic_selected = {
            gui = "bold",
        },
        warning_selected = {
            gui = "bold",
        },
        warning_diagnostic_selected = {
            gui = "bold",
        },
        error_selected = {
            gui = "bold",
        },
        error_diagnostic_selected = {
            gui = "bold",
        },
    },
})

require("core.utils").highlight_group("bufferline")
