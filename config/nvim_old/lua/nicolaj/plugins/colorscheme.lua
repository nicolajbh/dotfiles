return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
            },
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                -- Float windows
                NormalFloat = { bg = "none" },
                FloatBorder = { bg = "none" },
                FloatTitle = { bg = "none" },

                -- Dark windows for specific scenarios
                NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                -- Telescope customization
                TelescopeTitle = { fg = theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                -- Terminal customization
                TermCursor = { fg = theme.ui.bg, bg = theme.ui.fg },
                Terminal = { fg = theme.ui.fg, bg = theme.ui.bg },

                -- Additional tweaks for dragon theme
                LineNr = { fg = theme.ui.nontext },
                CursorLineNr = { fg = theme.ui.special, bold = true },

                -- Status line improvements
                StatusLine = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
                StatusLineNC = { bg = theme.ui.bg_m3, fg = theme.ui.nontext },

                -- For web development
                htmlTag = { fg = theme.syn.keyword, bold = true },
                htmlEndTag = { fg = theme.syn.keyword, bold = true },
                cssTagName = { fg = theme.syn.constant },
                cssClassName = { fg = theme.syn.identifier, italic = true },
                cssClassNameDot = { fg = theme.syn.identifier },
            }
        end,
        theme = "dragon", -- Using the dragon variant
        background = {
            dark = "dragon",
            light = "lotus",
        },
    },
    config = function(_, opts)
        require("kanagawa").setup(opts)
        vim.cmd.colorscheme("kanagawa")
    end,
}
