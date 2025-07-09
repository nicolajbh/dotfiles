return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        local conform = require("conform")

        -- Get the Mason installation path for ruff
        local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin"

        conform.setup({
            formatters_by_ft = {
                python = { "ruff_format" },
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                c = { "clang_format" },
                cpp = { "clang_format" },
            },
            format_on_save = {
                timeout_ms = 3000,
                lsp_fallback = true,
            },
            formatters = {
                ruff_format = {
                    command = mason_bin_path .. "/ruff", -- Use absolute path to Mason's ruff
                    args = { "format", "-" }, -- Minimal args for stdin formatting
                },
                stylua = {
                    prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                },
                prettier = {
                    prepend_args = { "--tab-width", "4", "--print-width", "100" },
                },
                clang_format = {
                    prepend_args = {
                        "--style=file", -- Use .clang-format file if present
                        "--fallback-style=Google", -- Otherwise use Google style
                    },
                },
            },
        })

        -- Key binding for manual formatting
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                async = true,
                lsp_fallback = true,
            })
        end, { desc = "Format file or range" })
    end,
}
