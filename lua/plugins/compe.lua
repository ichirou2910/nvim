local M = {}

M.config = function()
    require'compe'.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'always',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 25,
        max_kind_width = 25,
        max_menu_width = 25,
        documentation = {
            border = 'rounded', -- the border option is the same as `|help nvim_open_win|`
            winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
            max_width = 120,
            min_width = 60,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1
        },

        source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = true,
            nvim_lsp = true
            -- nvim_lua = {kind = "  "},
            -- nvim_lua = false,
            -- spell = {kind = "   (Spell)"},
            -- tags = false,
            -- vim_dadbod_completion = true,
            -- snippets_nvim = {kind = "  "},
            -- ultisnips = {kind = "  "},
            -- treesitter = {kind = "  "},
            -- emoji = {kind = " ﲃ  (Emoji)", filetypes = {"markdown", "text"}}
            -- for emoji press : (idk if that in compe tho)
        }
    }

    vim.api.nvim_exec([[
        inoremap <silent><expr> <C-Space> compe#complete()
        inoremap <silent><expr> <Tab>     compe#confirm('<Tab>')
        inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    ]], false)

end

return M
