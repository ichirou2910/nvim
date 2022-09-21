-- luasnip
local luasnip = require("luasnip")

-- load custom snippets first
require("luasnip.loaders.from_vscode").load({ paths = { "./lua/snippets" } })

-- externally provided snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

luasnip.filetype_extend("all", { "_" })
