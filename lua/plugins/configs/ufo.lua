local ok, ufo = pcall(require, "ufo")

if not ok then
    return
end

local ftMap = {
    vim = "indent",
    python = { "indent" },
    git = "",
}

local function provider_selector(bufnr)
    local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(providerName, bufnr)
        else
            return require("promise").reject(err)
        end
    end

    return require("ufo")
        .getFolds("lsp", bufnr)
        :catch(function(err)
            return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
            return handleFallbackException(err, "indent")
        end)
end

local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" ~ %d line(s)"):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

ufo.setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds = { "imports", "comment" },
    preview = {
        win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0,
        },
        mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
        },
    },
    provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or provider_selector
    end,
    fold_virt_text_handler = fold_virt_text_handler,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
