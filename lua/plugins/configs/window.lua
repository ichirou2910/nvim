local status_ok, nvim_window = pcall(require, "nvim-window")
if not status_ok then
    return
end

nvim_window.setup({
    chars = {
        "q",
        "w",
        "e",
        "r",
        "t",
        "a",
        "s",
        "d",
        "f",
        "g",
    },
    border = "rounded",
})
