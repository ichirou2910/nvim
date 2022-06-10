-- Install Packer.nvim if not on machine
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua"

local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

pcall(require, "impatient")
pcall(require, "packer_compiled")

require("packer").init({
    compile_path = compile_path,
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- local use = require("packer").use
require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "lewis6991/impatient.nvim" })

    use({ "nathom/filetype.nvim" })

    -- Necessary deps
    use("nvim-lua/popup.nvim")
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    -- Icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    })

    -- Indent
    use("tpope/vim-sleuth")
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
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
        keys = { "gc", "gcc", "gbc" },
        config = "require('plugins.configs.comment')",
    })

    -- Database
    use({ "tpope/vim-dadbod", config = vim.cmd([[ source ~/.config/nvim/configs/dadbod.vim ]]) })
    use({ "kristijanhusak/vim-dadbod-ui" })

    -- Repeat stuff
    use("tpope/vim-repeat")

    -- Text Navigation
    use({
        "unblevable/quick-scope",
        config = vim.cmd([[ source ~/.config/nvim/configs/quickscope.vim ]]),
    })

    -- Notification
    use({ "rcarriga/nvim-notify", event = "VimEnter", config = "require('plugins.configs.notify')" })

    -- Startup time
    use("tweekmonster/startuptime.vim")

    -- Async dispatch
    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

    -- Surround
    use({ "tpope/vim-surround", event = "InsertEnter" })

    -- Files
    use("tpope/vim-eunuch")
    use({
        -- "ichirou2910/nnn.vim",
        "mcchrish/nnn.vim",
        config = vim.cmd([[ source ~/.config/nvim/configs/nnn.vim]]),
    })
    use({
        "kyazdani42/nvim-tree.lua",
        event = "BufWinEnter",
        config = "require('plugins.configs.nvim-tree')",
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        as = "nvim-treesitter",
        run = ":TSUpdate",
        event = "BufRead",
        opt = true,
        config = "require('plugins.configs.treesitter')",
        requires = {
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
            { "jose-elias-alvarez/typescript.nvim" },
            { "Hoffs/omnisharp-extended-lsp.nvim" },
            {
                "nvim-treesitter/playground",
                cmd = "TSHighlightCapturesUnderCursor",
            },
            {
                "akinsho/flutter-tools.nvim",
                ft = "dart",
                config = "require('lsp.flutter')",
            },
        },
    })
    use({
        "windwp/nvim-autopairs",
        wants = "nvim-treesitter",
        module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
        config = "require('plugins.configs.pairs')",
    })
    use({
        "SmiteshP/nvim-gps",
        module = "nvim-gps",
        requires = "nvim-treesitter/nvim-treesitter",
        wants = "nvim-treesitter",
        config = "require('plugins.configs.nvim-gps')",
    })
    use({
        "windwp/nvim-ts-autotag",
        wants = "nvim-treesitter",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup({ enable = true })
        end,
    })

    -- Theme
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
    -- use({
    --     "chipsenkbeil/distant.nvim",
    --     config = function()
    --         require("distant").setup({
    --             -- Applies Chip's personal settings to every machine you connect to
    --             --
    --             -- 1. Ensures that distant servers terminate with no connections
    --             -- 2. Provides navigation bindings for remote directories
    --             -- 3. Provides keybinding to jump into a remote file's parent directory
    --             ["*"] = require("distant.settings").chip_default(),
    --         })
    --     end,
    -- })
    use({ "tpope/vim-fugitive", cmd = "Git" })
    use("junegunn/gv.vim")
    use({
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        wants = "plenary.nvim",
        requires = { "nvim-lua/plenary.nvim" },
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
        event = "VimEnter",
        config = "require('plugins.configs.which-key')",
    })

    -- Snippets
    use({
        "mattn/emmet-vim",
        ft = { "html", "typescriptreact", "javascriptreact" },
        config = "vim.g.user_emmet_leader_key = ','",
    })

    -- Debugging
    use({ "mfussenegger/nvim-dap", event = "BufWinEnter", as = "nvim-dap", config = "require('plugins.configs.dap')" })
    use({ "rcarriga/nvim-dap-ui", config = "require('plugins.configs.dap-ui')", after = "nvim-dap" })

    -- Smooth scroll
    use({ "psliwka/vim-smoothie", config = vim.cmd([[let g:smoothie_enabled = 1]]) })

    -- Markdown Preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        cmd = "MarkdownPreview",
        ft = "markdown",
        config = vim.cmd([[ source ~/.config/nvim/configs/markdown-preview.vim ]]),
    })
    use({ "tpope/vim-markdown", ft = "markdown" })

    -- Colorizer
    use({
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = "require('plugins.configs.colorizer')",
    })

    -- Seamless navigation with tmux
    -- use("christoomey/vim-tmux-navigator")
    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- overwrite default configuration
                -- here, e.g. to enable default bindings
                copy_sync = {
                    -- enables copy sync and overwrites all register actions to
                    -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
                    enable = true,
                },
                navigation = {
                    -- enables default keybindings (C-hjkl) for normal mode
                    enable_default_keybindings = true,
                },
                resize = {
                    -- enables default keybindings (A-hjkl) for normal mode
                    enable_default_keybindings = true,
                },
            })
        end,
    })

    -- Buffer navigation
    use({
        "ThePrimeagen/harpoon",
        module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
        wants = { "telescope.nvim" },
        config = "require('plugins.configs.harpoon)",
    })

    -- Tmux interaction from vim
    use({
        "preservim/vimux",
        config = vim.cmd([[ source ~/.config/nvim/configs/vimux.vim ]]),
    })

    -- Sessions
    -- use("tpope/vim-obsession")
    use({
        "rmagatti/auto-session",
        config = "require('plugins.configs.session')",
    })

    -- Window
    use({
        "https://gitlab.com/yorickpeterse/nvim-window.git",
        config = "require('plugins.configs.window')",
    })

    -- UI
    use({ "stevearc/dressing.nvim", event = "BufReadPre", config = "require('plugins.configs.dressing')" })

    -- Search
    use({
        "nvim-telescope/telescope.nvim",
        opt = true,
        module = { "telescope", "telescope.builtin" },
        as = "telescope",
        cmd = { "Telescope" },
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        wants = {
            "plenary.nvim",
            "popup.nvim",
            "telescope-fzf-native.nvim",
            "trouble.nvim",
        },
        config = "require('plugins.configs.telescope')",
    })

    -- Find and replace
    use({ "windwp/nvim-spectre", event = "VimEnter", config = "require('plugins.configs.spectre')" })

    -- Bars
    use({
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        after = "nvim-treesitter",
        config = "require('plugins.configs.lualine')",
        wants = "nvim-web-devicons",
    })
    use({
        "akinsho/bufferline.nvim",
        tag = "*",
        event = "BufReadPre",
        config = "require('plugins.configs.bufferline')",
    })

    -- Diagnostics
    use({
        "folke/trouble.nvim",
        event = "VimEnter",
        cmd = { "TroubleToggle", "Trouble" },
        config = "require('plugins.configs.trouble')",
    })

    -- Nvim LSP
    use({
        "jose-elias-alvarez/null-ls.nvim",
    })
    use({
        "neovim/nvim-lspconfig",
        event = "VimEnter",
        opt = true,
        wants = {
            "cmp-nvim-lsp",
            "null-ls.nvim",
            "typescript.nvim",
        },
        config = "require('lsp')",
        requires = {
            "jose-elias-alvarez/null-ls.nvim",
            "jose-elias-alvarez/typescript.nvim",
        },
    })
    use({
        "simrat39/symbols-outline.nvim",
        config = "require('plugins.configs.symbols')",
        event = "VimEnter",
        disable = true,
    })
    use({
        "ray-x/lsp_signature.nvim",
        config = "require('plugins.configs.signature')",
    })

    -- Shade
    -- use({ "sunjon/Shade.nvim", config = "require('plugins.configs.shade')" })

    -- Auto complete + snippets
    use({
        "onsails/lspkind-nvim",
        config = function()
            require("lspkind").init()
        end,
    })
    use({
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opt = true,
        wants = { "LuaSnip" },
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                wants = { "friendly-snippets", "vim-snippets" },
                config = function()
                    require("snip").setup()
                end,
            },
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
            "kristijanhusak/vim-dadbod-completion",
        },
        config = "require('plugins.configs.nvim-cmp')",
    })

    use({
        "hrsh7th/vim-vsnip",
        requires = { { "hrsh7th/vim-vsnip-integ" } },
        config = "require('plugins.configs.vsnip')",
    })

    -- Auto pairs for '(' '[' '{'
    if packer_bootstrap then
        print("Setting up... Restart required after installation!")
        require("packer").sync()
    end
end)
