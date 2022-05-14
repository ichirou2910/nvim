local M = {}

local snippets_folder = vim.fn.stdpath("config") .. "/lua/snip/snippets/"
local ls = require("luasnip")

function M.setup()
    ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = false,
    })

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_folder })

    vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])

    ls.filetype_extend("all", { "_" })
end

return M
