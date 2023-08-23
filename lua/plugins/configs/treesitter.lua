require("nvim-treesitter.configs").setup({
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(lang, buf)
            local max_filesize = 1000 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
    },
    rainbow = {
        enable = false,
        query = {
            "rainbow-parens",
            html = "rainbow-tags",
            tsx = "rainbow-tags",
        },
        hlgroups = {
            "TSRainbowRed",
            "TSRainbowOrange",
            "TSRainbowYellow",
            "TSRainbowGreen",
            "TSRainbowCyan",
            "TSRainbowViolet",
        },
    },
    patterns = {
        default = {
            "for",
            "while",
            "if",
            "switch",
            "case",
        },
        typescriptreact = {
            "jsx_element",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]b"] = "@block.outer",
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]B"] = "@block.outer",
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[b"] = "@block.outer",
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[B"] = "@block.outer",
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
})

require("core.utils").highlight_group("treesitter")
