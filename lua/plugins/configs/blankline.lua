vim.cmd([[
    if &diff
        let g:indent_blankline_enabled = v:false
    endif
]])

vim.cmd([[highlight IndentBlanklineContextStart1 guisp=#f7768e gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart2 guisp=#e0af68 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart3 guisp=#9ece6a gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart4 guisp=#1abc9c gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart5 guisp=#7aa2f7 gui=underline]])
vim.cmd([[highlight IndentBlanklineContextStart6 guisp=#bb9af7 gui=underline]])

require("indent_blankline").setup({
    viewport_buffer = 100,
    char = "▏",
    context_char = "▏",
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

local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
    highlight = {
        "rainbowcol1",
        "rainbowcol2",
        "rainbowcol3",
        "rainbowcol4",
        "rainbowcol5",
        "rainbowcol6",
    },
}
