local M = {}

M.config = function()
    -- if not package.loaded['which-key'] then
    --  return
    -- end
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    which_key.setup {
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
        border = "single", -- none, single, double, shadow
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
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = {"<leader>"}
    }

    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    -- Comments
    vim.api.nvim_set_keymap("n", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })

    -- Session
    vim.g.session_dir = "~/.vim/sessions"
    vim.api.nvim_set_keymap("n", "<leader>Ss", ":Obsession " .. vim.g.session_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>Sl", ":source " .. vim.g.session_dir .. "/*.vim<C-D><BS><BS><BS><BS><BS>", { noremap = true, silent = true })

    local mappings = {
      ["/"] = "Comment",
      [";"] = { ":Commands<CR>", "Commands" },
      ["="] = { "<C-W>=<CR>", "Balance windows" },
      ["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
      ["h"] = { "<C-W>s<CR>", "Split below" },
      ["n"] = { ":let @/=''<CR>", "No Highlight" },
      ["r"] = { ":FloatermNew ranger", "Ranger" },
      ["v"] = { "<C-W>v<CR>", "Split right" },
      ["p"] = { ":Files<CR>", "Find File" },
      ["q"] = { "<Plug>(wintabs_close)", "Close buffer" },
      ["<F5>"] = "which_key_ignore",
      ["<F8>"] = "which_key_ignore",
      ["<F9>"] = "which_key_ignore",

      g = {
        name = "Git",
        a = { "<cmd>Git add %<CR>", "Add current" },
        A = { "<cmd>Git add .<CR>", "Add all" },
        b = { "<cmd>Git blame<CR>", "Blame" },
        c = { "<cmd>Git commit<CR>", "Commit" },
        d = { "<cmd>Git diff<CR>", "Diff" },
        f = { "<cmd>Git fetch<CR>", "Fetch" },
        H = { "<Plug>(GitGutterPreviewHunk)", "Preview hunk" },
        j = { "<Plug>(GitGutterNextHunk)", "Next hunk" },
        k = { "<Plug>(GitGutterPrevHunk)", "Prev hunk" },
        l = { "<cmd>Git log<CR>", "Log" },
        p = { "<cmd>Git push<CR>", "Push" },
        P = { "<cmd>Git pull<CR>", "Pull" },
        r = { "<cmd>GRemove<CR>", "Remove" },
        s = { "<Plug>(GitGutterStageHunk)", "Stage hunk" },
        S = { "<cmd>Git<CR>", "Status" },
        u = { "<Plug>(GitGutterUndoHunk)", "Undo hunk" },
      },

      l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = {
          "<cmd>lua vim.lsp.buf.definition()<cr>",
          "Definition",
        },
        D = {
          "<cmd>lua vim.lsp.buf.declaration()<cr>",
          "Declaration",
        },
        f = "Format",
        i = {
          "<cmd>lua vim.lsp.buf.implementation()<cr>",
          "Implementation",
        },
        I = {
          "<cmd>Telescope lsp_workspace_diagnostics<cr>",
          "Diagnostics",
        },
        n = {
          "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
          "Next diagnostic",
        },
        p = {
          "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
          "Prev diagnostic",
        },
        z = { "<cmd>LspInfo<cr>", "Info" },
        q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      },

      s = {
        name = "Search",
        a = { "<cmd>Rg<cr>", "Text" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
      },

      S = {
        name = "Session",
        f = { "<cmd>Obsession!<CR>", "Stop record" },
        s = "Start record",
        l = "Load record",
      },
    }

    local wk = require "which-key"
    wk.register(mappings, opts)
end

return M
