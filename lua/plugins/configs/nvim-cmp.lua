local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")

local icons = require("core.ui.icons")

local WIDTH = 40

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            --[[ vim.fn["vsnip#anonymous"](args.body) ]]
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        completion = {
            border = { "", "", "", "", "", "", "", "" },
            winhighlight = "NormalFloat:CmpPmenu,CursorLine:PmenuSel,Search:None,FloatBorder:CmpBorder",
        },
        documentation = {
            border = { "", "", "", "", "", "", "", "" },
            winhighlight = "NormalFloat:CmpPmenu,FloatBorder:CmpBorder",
            maxwidth = math.floor((WIDTH * 2) * (vim.o.columns / (WIDTH * 2 * 16 / 9))),
            maxheight = math.floor(WIDTH * (WIDTH / vim.o.lines)),
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1,
            zindex = 100,
        },
    },

    mapping = {
        ["<c-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end),
        ["<c-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        --[[ ["<Tab>"] = cmp.mapping.confirm({ ]]
        --[[     behavior = cmp.ConfirmBehavior.Replace, ]]
        --[[     select = true, ]]
        --[[ }), ]]
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    formatting = {
        format = lspkind.cmp_format({
            menu = {
                buffer = "[Buf]",
                luasnip = "[Snip]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
                ["vim-dadbod-completion"] = "[DB]",
            },
            mode = "symbol_text",
            preset = "codicons",
            symbol_map = {
                Text = icons.kind.Text,
                Method = icons.kind.Method,
                Function = icons.kind.Function,
                Constructor = icons.kind.Constructor,
                Field = icons.kind.Field,
                Variable = icons.kind.Variable,
                Class = icons.kind.Class,
                Interface = icons.kind.Interface,
                Module = icons.kind.Module,
                Property = icons.kind.Property,
                Unit = icons.kind.Unit,
                Value = icons.kind.Value,
                Enum = icons.kind.Enum,
                Keyword = icons.kind.Keyword,
                Snippet = icons.kind.Snippet,
                Color = icons.kind.Color,
                File = icons.kind.File,
                Reference = icons.kind.Reference,
                Folder = icons.kind.Folder,
                EnumMember = icons.kind.EnumMember,
                Constant = icons.kind.Constant,
                Struct = icons.kind.Struct,
                Event = icons.kind.Event,
                Operator = icons.kind.Operator,
                TypeParameter = icons.kind.TypeParameter,
            },
        }),
    },

    sources = {
        { name = "luasnip", option = { use_show_condition = false } },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        { name = "vim-dadbod-completion" },
    },

    experimental = {
        ghost_text = true,
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

require("core.utils").highlight_group("cmp")
