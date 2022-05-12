local filter_bufname = {
    ["project-notes.notes"] = true,
}

vim.cmd("source ~/.config/nvim/configs/bbye.vim")

require("bufferline").setup({
    options = {
        diagnostics_indicator = function(count, _, _, _)
            return tostring(count)
        end,
        custom_filter = function(bufnr)
            if vim.fn.bufname(bufnr):match(".git/index$") then
                return false
            end
            if filter_bufname[vim.fn.bufname(bufnr)] == true then
                return false
            end
            return true
        end,
        diagnostics = "nvim_lsp",
        offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
            { filetype = "fugitive", text = "Git", text_align = "center" },
            { filetype = "notes", text = "Notes", text_align = "center" },
            { filetype = "Outline", text = "Outline", text_align = "center" },
        },
        separator_style = "slant",
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
