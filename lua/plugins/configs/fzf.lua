local ok, fzf = pcall(require, "fzf-lua")

if not ok then
    return
end

local layout_vertical = {
    height = 0.7,
    width = 0.55,
    preview = {
        layout = "vertical",
        vertical = "up:40%",
    },
}

fzf.setup({
    fzf_opts = { ["--cycle"] = "" },
    lsp = {
        code_actions = {
            winopts = layout_vertical,
        },
    },
})
