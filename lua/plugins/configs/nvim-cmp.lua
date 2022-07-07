local lspkind = require("lspkind")
local cmp = require("cmp")

local icons = require("core.ui.icons")

local WIDTH = 40

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    window = {
        completion = {
            border = border("CmpBorder"),
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
            border = border("CmpBorder"),
            winhighlight = "NormalFloat:CmpPmenu,FloatBorder:CompeDocumentationBorder",
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
        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },

    formatting = {
        format = lspkind.cmp_format({
            menu = {
                buffer = "[Buf]",
                nvim_lsp = "[LSP]",
                vsnip = "[Snip]",
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
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        { name = "vim-dadbod-completion" },
        -- { name = "neorg" },
    },

    experimental = {
        ghost_text = true,
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
