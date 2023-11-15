local modules = {
    "core.commands",
    "core.options",
    "core.mappings",
    "plugins",
    "core.autocmds",
    "core.clipboard",
    "core.ui",
}

if not vim.g.vscode then
    for _, module in ipairs(modules) do
        local ok, err = pcall(require, module)
        if not ok then
            error("Error loading " .. module .. "\n\n" .. err)
        end
    end
end
