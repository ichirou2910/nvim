local lspkind = require("lspkind")
local cmp = require("cmp")

local icons = require("core.ui.icons")

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
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", icons.kind[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "LSP",
                vsnip = "Snippet",
                buffer = "Buffer",
                path = "Path",
            })[entry.source.name]
            return vim_item
        end,
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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
