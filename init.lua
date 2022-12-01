local modules = { "core", "plugins" }

if not vim.g.vscode then
    for _, module in ipairs(modules) do
        local ok, err = pcall(require, module)
        if not ok then
            error("Error loading " .. module .. "\n\n" .. err)
        end
    end
end

if vim.g.started_by_firenvim then
    require("firenvim_init")
end
