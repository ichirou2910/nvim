local pairs = require("nvim-autopairs")

pairs.setup({ check_ts = true, disable_filetype = { "TelescopePrompt", "vim" } })
pairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
