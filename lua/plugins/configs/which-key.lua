local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local custom_border = require("core.utils").custom_border

which_key.setup({
    plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
        },
        spelling = { enabled = false, suggestions = 20 }, -- use which-key for spelling hints
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    window = {
        border = custom_border("WhichKeyBorder"),
        position = "bottom", -- bottom, top
        margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 5, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = false, -- show help message on the command line when the popup is visible
    triggers = { "<leader>" },
})

local opts = {
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}

local n_mappings = {
    [";"] = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    ["="] = { "<C-W>=", "Balance windows" },
    ["e"] = { ":NnnPicker %:p:h<CR>", "Explorer" },
    ["E"] = { ":NnnPicker<CR>", "Explorer" },
    ["n"] = { ":let @/=''<CR>", "No Highlight" },
    ["q"] = { ":BufferClose<CR>", "Close buffer" },
    ["w"] = { "<cmd>lua require('nvim-window').pick()<CR>", "Pick window" },
    ["-"] = { ":vnew<CR>", "New window right" },
    ["_"] = { ":new<CR>", "New window below" },
    ["<Up>"] = "Shade up",
    ["<Down>"] = "Shade down",

    b = {
        name = "Buffer",
        a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark" },
        b = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Mark menu" },
        p = { ":BufferPin<CR>", "Pin" },
        w = { ":BufferPick<CR>", "Pick" },
        z = { "<cmd>lua require('telescope').extensions.harpoon.marks()<cr>", "List marks" },
        s = {
            name = "Sort",
            b = { "<cmd>BufferOrderByBufferNumber<cr>", "By Buffer Number" },
            d = { "<cmd>BufferOrderByDirectory<cr>", "By Directory" },
            l = { "<cmd>BufferOrderByLanguage<cr>", "By Language" },
            w = { "<cmd>BufferOrderByWindowNumber<cr>", "By Window Number" },
        },
    },

    d = {
        name = "Debug",
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        t = { "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        z = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    },

    D = {
        name = "Database",
        z = { "<cmd>DBUIToggle<cr>", "Toggle UI" },
    },

    f = {
        name = "Find",
        a = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Text" },
        b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
        c = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Commits" },
        C = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", "Buffer Commits" },
        f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
        n = {
            "<cmd>Noice telescope<CR>",
            "Notifications",
        },
        r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        s = { "<cmd>lua require('telescope.builtin').search_history()<cr>", "Files" },
        w = {
            "<cmd>lua require('telescope.builtin').grep_string{word_match = '-w'}<cr>",
            "Word",
        },
    },

    g = {
        name = "Git",
        a = { "<cmd>Git add %<CR>", "Add current" },
        A = { "<cmd>Git add .<CR>", "Add all" },
        b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame" },
        c = { "<cmd>Git commit<CR>", "Commit" },
        d = { "<cmd>Gitsigns diffthis<CR>", "Diff this" },
        D = { "<cmd>lua require('gitsigns').diffthis('~')<CR>", "Diff last commit" },
        f = { "<cmd>Git fetch<CR>", "Fetch" },
        g = { "<cmd>diffget<CR>", "Diff get" },
        o = { "<cmd>diffput<CR>", "Diff put" },
        l = { "<cmd>Git log<CR>", "Log" },
        p = { "<cmd>Git push<CR>", "Push" },
        P = { "<cmd>Git pull<CR>", "Pull" },
        r = { "<cmd>GRemove<CR>", "Remove" },
        S = { "<cmd>vert Git<CR>", "Status" },
        u = "UI",
        v = {
            name = "View",
            v = { "<cmd>GV<CR>", "Commit all" },
            V = { "<cmd>GV<CR>", "Commit current" },
        },
        x = { "<cmd>Git restore %<CR>", "Restore" },
    },

    h = {
        name = "Git hunks",
        b = "Blame",
        p = "Preview",
        r = "Reset",
        R = "Reset buffer",
        s = "Stage",
        S = "Reset buffer",
        u = "Undo staged",
    },

    --[[ n = {}, ]]

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Code Lens" },
        d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        f = "Format",
        i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", "Implementation" },
        I = {
            "<cmd>Trouble workspace_diagnostics<cr>",
            "Diagnostics",
        },
        l = { "<cmd>Trouble loclist<cr>", "Loclist" },
        o = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Document Symbols" },
        p = {
            name = "Peek",
            d = { "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "Definition" },
            i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Implementation" },
        },
        q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
        r = { "<cmd>Trouble lsp_references<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
        z = { "<cmd>LspInfo<cr>", "Info" },
    },

    L = {
        name = "LSP Tools",
        f = {
            "<cmd>require('telescope').extensions.flutter.commands()<cr>",
            "Flutter",
        },
    },

    m = {
        name = "Minimap",
        f = { "<cmd>lua require('codewindow').toggle_focus()<cr>", "Toggle Focus" },
        m = { "<cmd>lua require('codewindow').toggle_minimap()<cr>", "Toggle Map" },
    },

    -- plugins/sidebar.vim
    s = {
        name = "Sidebar",
        b = "Debug",
        c = "Close sidebar",
        d = "Database",
        e = "NVIM Tree",
        g = "Git",
        n = "Notes",
    },

    S = {
        name = "Session",
        l = { "<cmd>RestoreSession<CR>", "Load record" },
        s = { "<cmd>SaveSession<CR>", "Start record" },
        x = { "<cmd>DeleteSession<CR>", "Stop record" },
    },

    t = {
        name = "Terminal",
        c = { "<cmd>VimuxPromptCommand<CR>", "Vimux commmand" },
        l = { "<cmd>VimuxRunLastCommand<CR>", "Vimux last commmand" },
        n = { "<cmd>call VimuxCreateNewPane<CR>", "Vimux new pane" },
        t = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
    },

    T = {
        name = "Tasks",
        d = { "<cmd>require('neotest').run.run({strategy = 'dap'})<cr>", "Debug test" },
        t = { "<cmd>require('neotest').run.run()<cr>", "Run test" },
    },

    u = {
        name = "UI",
        l = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" },
        s = "Toggle shade",
    },
}

local v_mappings = {
    f = {
        name = "Find",
        r = {
            "<cmd>lua require('spectre').open_visual()<cr>",
            "Replace",
        },
    },
    h = {
        name = "Git hunks",
        r = "Reset",
        s = "Stage",
    },

    l = {
        name = "LSP",
        a = {
            "<cmd>lua vim.lsp.buf.range_code_action()<cr>",
            "Code Action",
        },
        f = "Format",
    },
}

local wk = require("which-key")

wk.register(n_mappings, vim.tbl_extend("error", opts, { mode = "n" }))
wk.register(v_mappings, vim.tbl_extend("error", opts, { mode = "v" }))

require("core.utils").highlight_group("which-key")
