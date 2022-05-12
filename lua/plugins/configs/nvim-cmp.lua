local lspkind = require("lspkind")
local cmp = require("cmp")

local WIDTH = 40

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = {
            border = "rounded",
            winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
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
            -- menu = {
            --     buffer = "[Buf]",
            --     nvim_lsp = "[LSP]",
            --     vsnip = "[Snip]",
            --     path = "[Path]",
            -- },
            mode = "symbol_text",
            preset = "codicons",
            symbol_map = {
                Text = " ",
                Method = " ",
                Function = " ",
                Constructor = " ",
                Field = " ",
                Variable = " ",
                Class = " ",
                Interface = " ",
                Module = " ",
                Property = " ",
                Unit = " ",
                Value = " ",
                Enum = " ",
                Keyword = " ",
                Snippet = " ",
                Color = " ",
                File = " ",
                Reference = " ",
                Folder = " ",
                EnumMember = " ",
                Constant = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            },
        }),
        -- format = function(entry, vim_item)
        -- -- Menu width
        -- vim_item.abbr = string.sub(vim_item.abbr, 1, 40)
    },

    sources = {
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        -- { name = "neorg" },
    },

    experimental = {
        ghost_text = true,
    },
})
