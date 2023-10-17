require("spectre").setup({
    color_devicons = true,
    live_update = true, -- auto excute search again when you write any file in vim
    highlight = { ui = "String", search = "DiffChange", replace = "DiffDelete" },
    is_block_ui_break = true,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "spectre_panel",
    callback = function()
        vim.wo.signcolumn = "no"
    end,
})
