-- Install Packer.nvim if not on machine
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua"

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

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({ "lewis6991/impatient.nvim" })

    -- Text Navigation
    use({
        "unblevable/quick-scope",
        config = vim.cmd([[ source ~/.config/nvim/configs/quickscope.vim ]]),
    })

    use({
        "folke/neodev.nvim",
        config = function()
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            require("neodev").setup({
                library = {
                    runtime = runtime_path,
                    plugins = { "nvim-dap-ui" },
                    types = true,
                },
            })
        end,
    })

    use({
        "vimwiki/vimwiki",
        ft = "vimwiki",
        config = function()
            vim.g.vimwiki_list = {
                {
                    path = "~/Wiki/",
                    syntax = "markdown",
                    ext = ".wiki",
                },
            }
        end,
    })

    -- Icons
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
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

    -- Notification
    use({
        "rcarriga/nvim-notify",
        config = "require('plugins.configs.notify')",
    })

    -- Startup time
    use("tweekmonster/startuptime.vim")

    -- Async dispatch
    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

    -- Surround
    use({ "tpope/vim-surround", event = "InsertEnter" })

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
        config = "require('plugins.configs.treesitter')",
    })
    use({
        "nvim-treesitter/playground",
        cmd = "TSHighlightCapturesUnderCursor",
    })
    use({
        "https://gitlab.com/HiPhish/nvim-ts-rainbow2.git",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
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

    use({
        "rest-nvim/rest.nvim",
        ft = "http",
        requires = { "nvim-lua/plenary.nvim" },
        config = "require('plugins.configs.rest')",
    })

    -- Indent
    use("tpope/vim-sleuth")
    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = "require('plugins.configs.blankline')",
    })

    use({
        "kevinhwang91/nvim-ufo",
        requires = "kevinhwang91/promise-async",
        config = "require('plugins.configs.ufo')",
    })

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
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = "require('plugins.configs.diffview')",
    })
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
        config = "require('plugins.configs.which-key')",
    })

    -- Snippets
    use({
        "mattn/emmet-vim",
        ft = { "html", "typescriptreact", "javascriptreact" },
        config = vim.cmd([[ let g:user_emmet_leader_key = ',' ]]),
    })

    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        event = "BufWinEnter",
        as = "nvim-dap",
        module = "dap",
        config = "require('plugins.configs.dap')",
    })
    use({ "rcarriga/nvim-dap-ui", config = "require('plugins.configs.dap-ui')", after = "nvim-dap" })
    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    })
    use({
        "Weissle/persistent-breakpoints.nvim",
        wants = "nvim-dap",
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

    use({
        "jbyuki/venn.nvim",
        config = "require('plugins.configs.venn')",
    })

    -- Colorizer
    use({
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = "require('plugins.configs.colorizer')",
    })

    -- Seamless navigation with tmux
    use({
        "aserowy/tmux.nvim",
        disable = true,
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
    use("folke/tokyonight.nvim")
    use({ "stevearc/dressing.nvim", event = "BufReadPre", config = "require('plugins.configs.dressing')" })
    use({
        "folke/noice.nvim",
        -- disable = true,
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
            "nvim-telescope/telescope-file-browser.nvim",
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
    use({ "windwp/nvim-spectre", config = "require('plugins.configs.spectre')" })

    -- Bars
    use({
        "nvim-lualine/lualine.nvim",
        after = "nvim-treesitter",
        config = "require('plugins.configs.lualine')",
        wants = "nvim-web-devicons",
    })

    use({
        "romgrk/barbar.nvim",
        requires = { "kyazdani42/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
        config = "require('plugins.configs.barbar')",
    })

    use({
        "luukvbaal/statuscol.nvim",
        config = "require('plugins.configs.statuscol')",
    })

    use({
        "b0o/incline.nvim",
        config = "require('plugins.configs.incline')",
    })

    -- Diagnostics
    use({
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = "require('plugins.configs.trouble')",
    })

    -- Nvim LSP
    use({
        "williamboman/mason.nvim",
    })
    use({
        "williamboman/mason-lspconfig.nvim",
        requires = {
            "williamboman/mason.nvim",
        },
    })
    use({
        "neovim/nvim-lspconfig",
        wants = {
            "nvim-cmp",
            "null-ls.nvim",
            "typescript.nvim",
            "lsp-inlayhints.nvim",
        },
        config = "require('lsp')",
        requires = {
            "jose-elias-alvarez/null-ls.nvim",
            "jose-elias-alvarez/typescript.nvim",
            "p00f/clangd_extensions.nvim",
            { "Hoffs/omnisharp-extended-lsp.nvim" },
            { "Decodetalkers/csharpls-extended-lsp.nvim" },
            { "jayp0521/mason-null-ls.nvim", commit = "ab5d99619de2263508abb7fb05ef3a0f24a8d73d" },
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
                height = 20,
            })
        end,
        after = { "nvim-lspconfig" },
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
        disable = true,
        branch = "anticonceal",
        event = "LspAttach",
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
        requires = {
            "kristijanhusak/vim-dadbod-completion",
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                wants = { "friendly-snippets" },
                config = "require('plugins.configs.snips')",
            },
        },
        config = "require('plugins.configs.nvim-cmp')",
    })
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")

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
end)
