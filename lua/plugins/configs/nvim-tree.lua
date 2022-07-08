local ok, nvim_tree = pcall(require, "nvim-tree")

if not ok then
    return
end

nvim_tree.setup({
    disable_netrw = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        width = 55,
    },
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
})

require("core.utils").highlight_group("nvim-tree")
