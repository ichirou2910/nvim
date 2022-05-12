local core_modules = {
    "core.custom",
    "core.options",
    "core.mappings",
    "core.colorscheme",
    "core.highlights",
}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
