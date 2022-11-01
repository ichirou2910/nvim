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

    -- Rest client
    use({
        "rest-nvim/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = "require('plugins.configs.rest')",
    })

    -- Files
    use("tpope/vim-eunuch")
    use({
        "luukvbaal/nnn.nvim",
        config = "require('plugins.configs.nnn')",
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
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("treesitter-context").setup({
                        patterns = {
                            default = {
                                "for",
                                "while",
                                "if",
                                "switch",
                                "case",
                            },
                        },
                    })
                end,
            },
            { "Hoffs/omnisharp-extended-lsp.nvim" },
            {
                "nvim-treesitter/playground",
                cmd = "TSHighlightCapturesUnderCursor",
            },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "https://git.sr.ht/~p00f/nvim-ts-rainbow" },
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
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    })
    use({
        "Weissle/persistent-breakpoints.nvim",
        requires = "mfussenegger/nvim-dap",
        config = function()
            require("persistent-breakpoints").setup({
                save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
                load_breakpoints_event = { "BufReadPost" },
                perf_record = false,
            })
        end,
    })

    -- Smooth scroll
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })

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
                    redirect_to_clipboard = true,
                },
                navigation = {
                    enable_default_keybindings = true,
                    persist_zoom = true,
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
    use({
        "folke/noice.nvim",
        config = "require('plugins.configs.noice')",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    })

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
    use({
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end,
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
            "lsp-inlayhints.nvim",
        },
        config = "require('lsp')",
        requires = {
            "jose-elias-alvarez/null-ls.nvim",
            "jose-elias-alvarez/typescript.nvim",
        },
    })
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        after = { "nvim-lspconfig" },
        config = function()
            require("lsp_lines").setup()
        end,
    })
    use({
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                border = { "", "", "", "", "", "", "", "" },
            })
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
        "lvimuser/lsp-inlayhints.nvim",
        --[[ branch = "anticonceal", ]]
        config = "require('plugins.configs.inlay-hints')",
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
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-cmdline",
            "kristijanhusak/vim-dadbod-completion",
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
            {
                "L3MON4D3/LuaSnip",
                wants = { "friendly-snippets", "vim-snippets" },
                config = "require('plugins.configs.snips')",
            },
        },
        config = "require('plugins.configs.nvim-cmp')",
    })

    -- Testing
    use({
        "nvim-neotest/neotest",
        config = "require('plugins.configs.neotest')",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
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
