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
    max_jobs = 9,
})

-- local use = require("packer").use
require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "lewis6991/impatient.nvim" })

    use({ "nathom/filetype.nvim" })

    -- Necessary deps
    use("nvim-lua/popup.nvim")
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    -- Optimize
    use({ "antoinemadec/FixCursorHold.nvim", config = vim.cmd([[let g:cursorhold_updatetime = 100]]) })

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

    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = "require('plugins.configs.ufo')",
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

    -- Editorconfig
    use({ "gpanders/editorconfig.nvim" })

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
            { "Hoffs/omnisharp-extended-lsp.nvim" },
            {
                "nvim-treesitter/playground",
                cmd = "TSHighlightCapturesUnderCursor",
            },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "p00f/nvim-ts-rainbow" },
        },
    })
    use({
        "windwp/nvim-autopairs",
        wants = "nvim-treesitter",
        module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
        config = "require('plugins.configs.pairs')",
    })
    use({
        "SmiteshP/nvim-navic",
        module = "nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = "require('plugins.configs.navic')",
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
    -- use("folke/tokyonight.nvim")

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
    use({ "tpope/vim-fugitive", cmd = { "G", "Git" } })
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
        config = vim.cmd([[ let g:user_emmet_leader_key = ',' ]]),
    })

    -- Debugging
    use({ "mfussenegger/nvim-dap", event = "BufWinEnter", as = "nvim-dap", config = "require('plugins.configs.dap')" })
    use({ "rcarriga/nvim-dap-ui", config = "require('plugins.configs.dap-ui')", after = "nvim-dap" })
    use({
        "Weissle/persistent-breakpoints.nvim",
        requires = "mfussenegger/nvim-dap",
        config = function()
            require("persistent-breakpoints").setup({})
            vim.api.nvim_create_autocmd(
                { "BufReadPost" },
                { callback = require("persistent-breakpoints.api").load_breakpoints }
            )
        end,
    })

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
    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = {
                    enable = true,
                },
                navigation = {
                    enable_default_keybindings = true,
                },
                resize = {
                    enable_default_keybindings = true,
                },
            })
        end,
    })

    -- Buffer navigation
    use({
        "ThePrimeagen/harpoon",
        module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
        wants = { "telescope" },
        config = "require('plugins.configs.harpoon')",
    })

    -- Tmux interaction from vim
    use({
        "preservim/vimux",
        config = vim.cmd([[ source ~/.config/nvim/configs/vimux.vim ]]),
    })

    -- Sessions
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
    -- use({
    --     "akinsho/bufferline.nvim",
    --     tag = "*",
    --     event = "BufReadPre",
    --     config = "require('plugins.configs.bufferline')",
    -- })
    use({
        "romgrk/barbar.nvim",
        event = "BufReadPre",
        requires = { "kyazdani42/nvim-web-devicons" },
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
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({})
        end,
        after = { "nvim-lspconfig" },
    })
    use({
        "ray-x/lsp_signature.nvim",
        config = "require('plugins.configs.signature')",
    })
    use({
        "akinsho/flutter-tools.nvim",
        ft = "dart",
        config = "require('lsp.flutter')",
    })
    use({
        "simrat39/rust-tools.nvim",
        config = "require('lsp.rust')",
        after = { "nvim-lspconfig" },
    })
    use({
        "RishabhRD/nvim-lsputils",
        requires = { "RishabhRD/popfix" },
        after = { "nvim-lspconfig" },
    })

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
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-cmdline",
            "kristijanhusak/vim-dadbod-completion",
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
        },
        config = "require('plugins.configs.nvim-cmp')",
    })

    use({
        "hrsh7th/vim-vsnip",
        requires = { { "hrsh7th/vim-vsnip-integ" } },
        config = "require('plugins.configs.vsnip')",
    })

    -- Testing
    use({
        "nvim-neotest/neotest",
        config = "require('plugins.configs.neotest')",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            { "nvim-neotest/neotest-vim-test", requires = "vim-test/vim-test" },
            { "Issafalcon/neotest-dotnet" },
            { "rouge8/neotest-rust" },
        },
    })

    if packer_bootstrap then
        print("Setting up... Restart required after installation!")
        require("packer").sync()
    end
end)
