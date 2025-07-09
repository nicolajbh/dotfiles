-- lua/nicolaj/plugins/statusline.lua
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "rebelot/kanagawa.nvim",
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "kanagawa",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true, -- Single statusline for all windows
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        {
                            "diff",
                            colored = true,
                            diff_color = {
                                added = { fg = "#76946A" }, -- green
                                modified = { fg = "#DCA561" }, -- orange
                                removed = { fg = "#C34043" }, -- red
                            },
                            symbols = { added = "+", modified = "~", removed = "-" },
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            file_status = true,
                            path = 1, -- relative path
                            shorting_target = 40,
                            symbols = {
                                modified = "[+]",
                                readonly = "[RO]",
                                unnamed = "[No Name]",
                                newfile = "[New]",
                            },
                        },
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                            colored = true,
                            diagnostics_color = {
                                error = { fg = "#E82424" },
                                warn = { fg = "#FF9E3B" },
                                info = { fg = "#658594" },
                                hint = { fg = "#6A9589" },
                            },
                        },
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = { "nvim-tree", "fugitive", "quickfix" },
            })
        end,
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("bufferline").setup({
                options = {
                    mode = "tabs",
                    -- Minimal, clean configuration
                    numbers = "ordinal",
                    separator_style = "thin",
                    indicator = {
                        style = "none", -- No special indicator
                    },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    color_icons = true,
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                    show_tab_indicators = false,

                    -- Custom section styling
                    modified_icon = "●",
                    max_name_length = 20,

                    -- No diagnostics or fancy indicators
                    diagnostics = false,

                    -- Offset for file explorer if present
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = false,
                        },
                    },

                    -- Disable fancy hover effects
                    hover = {
                        enabled = false,
                    },
                },

                -- Very minimal highlights to avoid theme conflicts
                highlights = {
                    -- No custom colors - let the terminal theme handle it
                },
            })

            -- Always show tabs
            vim.opt.showtabline = 2
            vim.opt.termguicolors = true
        end,
    },
}
