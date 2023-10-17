local ok, ll = pcall(require, "lsp_lines")

if not ok then
    return
end

-- Disable the plugin in Lazy.nvim
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function()
        local previous = not ll.toggle()
        if not previous then
            ll.toggle()
        end
    end,
})

ll.setup({
    virtual_text = false,
})

ll.toggle() -- Comment to disable on startup
local previously = not ll.toggle()

local group = vim.api.nvim_create_augroup("LspLinesToggleInsert", { clear = false })

vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function()
        previously = not ll.toggle()
        if not previously then
            ll.toggle()
        end
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function()
        if ll.toggle() ~= previously then
            ll.toggle()
        end
    end,
})
