-- Install Lazy.nvim if not on machine
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
            -- stylua: ignore
            keys = {
                { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
                { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
                { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
                { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
                { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
            },
    },

    {
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
    },

    {
        "stevearc/overseer.nvim",
        config = function()
            require("overseer").setup({
                dap = false,
            })
        end,
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    },

    -- Working dir
    {
        "notjedi/nvim-rooter.lua",
        config = function()
            require("nvim-rooter").setup()
        end,
    },

    -- Better Comments
    {
        "numToStr/Comment.nvim",
        --[[ keys = { "gc", "gcc", "gbc" }, ]]
        config = function()
            require("plugins.configs.comment")
        end,
    },

    -- Repeat stuff
    "tpope/vim-repeat",

    -- Notification
    {
        "rcarriga/nvim-notify",
        config = function()
            require("plugins.configs.notify")
        end,
    },

    -- Surround
    { "tpope/vim-surround", event = "InsertEnter" },

    -- Files
    "tpope/vim-eunuch",
    {
        "luukvbaal/nnn.nvim",
        config = function()
            require("plugins.configs.nnn")
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        opts = require("plugins.configs.neotree"),
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufRead",
        config = function()
            require("plugins.configs.treesitter")
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    {
        "windwp/nvim-autopairs",
        module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
        config = function()
            require("plugins.configs.pairs")
        end,
    },
    {
        "SmiteshP/nvim-navic",
        module = "nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("plugins.configs.navic")
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup({ enable = true })
        end,
    },

    {
        "rest-nvim/rest.nvim",
        ft = "http",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.rest")
        end,
    },

    -- Indent
    "tpope/vim-sleuth",
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            require("plugins.configs.blankline")
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            require("plugins.configs.ufo")
        end,
    },

    -- Sidebar manager
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        opts = require("plugins.configs.edgy"),
    },

    -- Git
    { "tpope/vim-fugitive", cmd = { "G", "Git" } },
    --[[ use("junegunn/gv.vim") ]]
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen" },
        config = function()
            require("plugins.configs.diffview")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.configs.gitsigns")
        end,
    },

    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        config = function()
            require("plugins.configs.toggleterm")
        end,
    },

    -- WhichKey
    {
        "folke/which-key.nvim",
        config = function()
            require("plugins.configs.which-key")
        end,
    },

    -- Snippets
    {
        "mattn/emmet-vim",
        ft = { "html", "typescriptreact", "javascriptreact" },
        config = function()
            vim.cmd([[ let g:user_emmet_leader_key = ',' ]])
        end,
    },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        event = "BufWinEnter",
        module = "dap",
        config = function()
            require("plugins.configs.dap")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("plugins.configs.dap-ui")
        end,
        dependencies = { "mfussenegger/nvim-dap" },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    },
    {
        "Weissle/persistent-breakpoints.nvim",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("persistent-breakpoints").setup({
                save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
                load_breakpoints_event = { "BufReadPost" },
                perf_record = false,
            })
        end,
    },

    -- Smooth scroll
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        cmd = "MarkdownPreview",
        ft = "markdown",
        config = function()
            vim.cmd([[ source ~/.config/nvim/configs/markdown-preview.vim ]])
        end,
    },

    {
        "jbyuki/venn.nvim",
        ft = "markdown",
        config = function()
            require("plugins.configs.venn")
        end,
    },

    -- Colorizer
    {
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
            require("plugins.configs.colorizer")
        end,
    },

    -- Buffer navigation
    {
        "ThePrimeagen/harpoon",
        module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("plugins.configs.harpoon")
        end,
    },

    -- Sessions
    {
        "rmagatti/auto-session",
        config = function()
            require("plugins.configs.session")
        end,
    },

    -- UI
    "folke/tokyonight.nvim",
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.configs.dressing")
        end,
    },
    {
        "folke/noice.nvim",
        -- disable = true,
        config = function()
            require("plugins.configs.noice")
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    -- Search
    {
        "nvim-telescope/telescope.nvim",
        module = { "telescope", "telescope.builtin" },
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            require("plugins.configs.telescope")
        end,
    },
    {
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end,
    },

    -- Find and replace
    {
        "windwp/nvim-spectre",
        config = function()
            require("plugins.configs.spectre")
        end,
    },

    -- Bars
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.configs.lualine")
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "romgrk/barbar.nvim",
        dependencies = { "lewis6991/gitsigns.nvim" },
        config = function()
            require("plugins.configs.barbar")
        end,
    },

    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("plugins.configs.statuscol")
        end,
    },

    {
        "b0o/incline.nvim",
        config = function()
            require("plugins.configs.incline")
        end,
    },

    -- Diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("plugins.configs.trouble")
        end,
    },

    -- Nvim LSP
    {
        "williamboman/mason.nvim",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
        dependencies = {
            "Hoffs/omnisharp-extended-lsp.nvim",
            "Decodetalkers/csharpls-extended-lsp.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            { "jayp0521/mason-null-ls.nvim", commit = "ab5d99619de2263508abb7fb05ef3a0f24a8d73d" },
            "pmizio/typescript-tools.nvim",
        },
    },
    {
        "aurum77/dotnet.nvim",
        ft = "csharp",
        config = function()
            require("dotnet").setup()
        end,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("plugins.configs.lsp-lines")
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                border = { "", "", "", "", "", "", "", "" },
                height = 20,
            })
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("lsp.rust")
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },

    -- Auto complete + snippets
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("plugins.configs.snips")
                end,
            },
            {
                "onsails/lspkind-nvim",
                config = function()
                    require("lspkind").init()
                end,
            },
        },
        config = function()
            require("plugins.configs.nvim-cmp")
        end,
    },

    -- Testing
    {
        "nvim-neotest/neotest",
        lazy = true,
        config = function()
            require("plugins.configs.neotest")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "Issafalcon/neotest-dotnet",
            "rouge8/neotest-rust",
        },
    },

    -- Obsidian
    {
        "epwalsh/obsidian.nvim",
        event = {
            "BufReadPre /media/home/ichirou2910/Documents/Obsidian/**/*.md",
            "BufNewFile /media/home/ichirou2910/Documents/Obsidian/**/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = require("plugins.configs.obsidian"),
    },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "rplugin",
                "shada",
                "spellfile",
            },
        },
    },
})
