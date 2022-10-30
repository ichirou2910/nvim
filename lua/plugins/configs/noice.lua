local ok, noice = pcall(require, "noice")

if not ok then
    return
end

noice.setup({
    views = {},
})

require("core.utils").highlight_group("noice")
