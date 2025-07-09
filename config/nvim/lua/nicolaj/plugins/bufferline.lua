-- lua/nicolaj/plugins/bufferline.lua
return {
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
                separator_style = "thin",
                indicator = {
                    style = "underline", -- Underline indicator is more subtle
                },
                show_buffer_close_icons = false,
                show_close_icon = false,
                color_icons = true,
                enforce_regular_tabs = true,
                always_show_bufferline = true,
                show_tab_indicators = false,
                tab_size = 22, -- Slightly wider tabs

                -- Custom section styling
                modified_icon = "●",
                left_trunc_marker = "",
                right_trunc_marker = "",
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

                -- Custom formatting for tab names
                name_formatter = function(tab)
                    return tab.tabnr .. ": " .. tab.name
                end,
            },

            -- Very minimal highlights to avoid theme conflicts
            highlights = {
                -- No custom colors - let the terminal theme handle it
            },
        })

        -- Set tab mappings
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
        vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
        vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
        vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
        vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
        vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
        vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
        vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
        vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
        vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
        vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
        vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })

        vim.opt.termguicolors = true
        vim.opt.showtabline = 2 -- Always show tabs
    end,
}
