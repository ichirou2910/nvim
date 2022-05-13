-- Install Packer.nvim if not on machine
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

-- local use = require("packer").use
require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "lewis6991/impatient.nvim" })

    use({ "nathom/filetype.nvim" })

    -- Indent
    use("tpope/vim-sleuth")
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        config = "require('plugins.configs.blankline')",
    })

    -- Working dir
    use({
        "notjedi/nvim-rooter.lua",
        config = function()
            require("nvim-rooter").setup()
        end,
    })

    -- Better Comments
    use({
        "numToStr/Comment.nvim",
        config = "require('plugins.configs.comment')",
    })

    -- Repeat stuff
    use("tpope/vim-repeat")

    -- Text Navigation
    use({
        "unblevable/quick-scope",
        config = vim.cmd([[ source ~/.config/nvim/configs/quickscope.vim ]]),
    })

    -- Notification
    use({ "rcarriga/nvim-notify", config = "require('plugins.configs.notify')" })

    -- Startup time
    use("tweekmonster/startuptime.vim")

    -- Async dispatch
    use({ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } })

    -- Surround
    use({ "tpope/vim-surround", event = "BufRead" })

    -- Files
    use("tpope/vim-eunuch")
    use({
        "ichirou2910/nnn.vim",
        config = vim.cmd([[ source ~/.config/nvim/configs/nnn.vim]]),
    })
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        event = "BufWinEnter",
        config = "require('plugins.configs.nvim-tree')",
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = "require('plugins.configs.treesitter')",
    })
    use({
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        after = "nvim-treesitter",
    })
    use({
        "SmiteshP/nvim-gps",
        module = "nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        config = "require('plugins.configs.nvim-gps')",
    })

    -- Theme
    use("olimorris/onedarkpro.nvim")
    use("folke/tokyonight.nvim")

    -- Cmake
    use({
        "ilyachur/cmake4vim",
        cmd = { "CMake", "CMakeBuild" },
        config = vim.cmd([[ source ~/.config/nvim/configs/cmake4vim.vim ]]),
    })

    -- Quickfix
    use({ "kevinhwang91/nvim-bqf", ft = "qf", event = "BufWinEnter" })

    -- Sidebar manager
    use({
        "ichirou2910/vim-sidebar-manager",
        config = vim.cmd([[ source ~/.config/nvim/configs/sidebar.vim ]]),
    })

    -- Git
    use({
        "chipsenkbeil/distant.nvim",
        config = function()
            require("distant").setup({
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory
                ["*"] = require("distant.settings").chip_default(),
            })
        end,
    })
    use({ "tpope/vim-fugitive" })
    use("junegunn/gv.vim")
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = "require('plugins.configs.gitsigns')",
    })

    -- Terminal
    use({
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        config = "require('plugins.configs.toggleterm')",
    })

    -- WhichKey
    use({
        "folke/which-key.nvim",
        config = "require('plugins.configs.which-key')",
    })

    -- Snippets
    use({
        "mattn/emmet-vim",
        ft = { "html", "typescriptreact", "javascriptreact" },
        config = "vim.g.user_emmet_leader_key = ','",
    })

    -- Debugging
    use({ "mfussenegger/nvim-dap", config = "require('plugins.configs.dap')" })
    use({ "rcarriga/nvim-dap-ui", config = "require('plugins.configs.dap-ui')", after = "nvim-dap" })

    -- Smooth scroll
    use({ "psliwka/vim-smoothie", config = vim.cmd([[let g:smoothie_enabled = 1]]) })

    -- Markdown Preview
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        -- cmd = "MarkdownPreview",
        config = vim.cmd([[ source ~/.config/nvim/configs/markdown-preview.vim ]]),
    })
    use({ "tpope/vim-markdown", ft = "markdown" })

    -- Colorizer
    use({
        "norcalli/nvim-colorizer.lua",
        config = "require('plugins.configs.colorizer')",
    })

    -- Seamless navigation with tmux
    use("christoomey/vim-tmux-navigator")

    -- Buffer navigation
    use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } })

    -- Tmux interaction from vim
    use({
        "preservim/vimux",
        config = vim.cmd([[ source ~/.config/nvim/configs/vimux.vim ]]),
    })

    -- Sessions
    use("tpope/vim-obsession")

    -- Window
    use({
        "https://gitlab.com/yorickpeterse/nvim-window.git",
        config = "require('plugins.configs.window')",
    })

    -- UI
    use({ "stevearc/dressing.nvim", config = "require('plugins.configs.dressing')" })

    -- Search
    use({
        "nvim-telescope/telescope.nvim",
        module = "telescope",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        wants = { "popup.nvim", "plenary.nvim", "telescope-fzf-native.nvim" },
        config = "require('plugins.configs.telescope')",
    })

    -- Necessary deps
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")

    -- Find and replace
    use({ "windwp/nvim-spectre", config = "require('plugins.configs.spectre')" })

    -- Bars
    use({
        "nvim-lualine/lualine.nvim",
        after = "nvim-treesitter",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = "require('plugins.configs.lualine')",
    })
    use({
        "akinsho/bufferline.nvim",
        tag = "*",
        requires = "kyazdani42/nvim-web-devicons",
        config = "require('plugins.configs.bufferline')",
    })

    -- Diagnostics
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
        cmd = { "TroubleToggle", "Trouble" },
        config = "require('plugins.configs.trouble')",
    })

    -- Nvim LSP
    use({
        "neovim/nvim-lspconfig",
        after = "nvim-treesitter",
        event = "BufRead",
        -- opt = true,
        requires = {
            "jose-elias-alvarez/null-ls.nvim",
            "Hoffs/omnisharp-extended-lsp.nvim",
            "jose-elias-alvarez/nvim-lsp-ts-utils",
        },
        config = "require('plugins.configs.lspconfig')",
    })
    use({ "simrat39/symbols-outline.nvim", config = "require('plugins.configs.symbols')" })
    use({
        "ray-x/lsp_signature.nvim",
        config = "require('plugins.configs.signature')",
    })
    use({
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        config = "require('lsp.flutter')",
    })

    -- Shade
    use({ "sunjon/Shade.nvim", config = "require('plugins.configs.shade')" })

    -- Auto complete + snippets
    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        -- opt = true,
        requires = {
            "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
        },
        config = "require('plugins.configs.nvim-cmp')",
    })

    use({
        "hrsh7th/vim-vsnip",
        requires = { { "hrsh7th/vim-vsnip-integ" } },
        after = "nvim-cmp",
        config = "require('plugins.configs.vsnip')",
    })

    -- Auto pairs for '(' '[' '{'
    use({
        "windwp/nvim-autopairs",
        run = "make",
        after = "nvim-cmp",
        config = "require('plugins.configs.pairs')",
    })
end)
