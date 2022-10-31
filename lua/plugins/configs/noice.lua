local ok, noice = pcall(require, "noice")

if not ok then
    return
end

noice.setup({})

--[[ require("core.utils").highlight_group("noice") ]]
