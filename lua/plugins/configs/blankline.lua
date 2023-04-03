vim.cmd([[
    if &diff
        let g:indent_blankline_enabled = v:false
    endif
]])

vim.cmd([[highlight IndentBlanklineContextChar guifg=#f38ba8 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextStart0 guisp=#f38ba8 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart1 guisp=#ed8796 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart2 guisp=#f5a97f gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart3 guisp=#eed49f gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart4 guisp=#a6da95 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart5 guisp=#7dc4e4 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart6 guisp=#c6a0f6 gui=underline]])

require("indent_blankline").setup({
    viewport_buffer = 100,
    char = "▏", -- '│'
    context_char = "▏", -- '│'
    filetype_exclude = {
        "vimwiki",
        "man",
        "diagnosticpopup",
        "lspinfo",
        "packer",
        "markdown",
        "TelescopePrompt",
        "TelescopeResults",
        "WhichKey",
        "",
    },
    context_highlight_list = {
        "rainbowcol1",
        "rainbowcol2",
        "rainbowcol3",
        "rainbowcol4",
        "rainbowcol5",
        "rainbowcol6",
    },
    context_start_highlight_list = {
        --[[ "IndentBlanklineContextStart0", ]]
        "IndentBlanklineContextStart1",
        "IndentBlanklineContextStart2",
        "IndentBlanklineContextStart3",
        "IndentBlanklineContextStart4",
        "IndentBlanklineContextStart5",
        "IndentBlanklineContextStart6",
    },
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    show_foldtext = false,
    strict_tabs = true,
})
