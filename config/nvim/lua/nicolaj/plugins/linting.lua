return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- Configure linters by filetype
        lint.linters_by_ft = {
            python = { "ruff" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            css = { "stylelint" },
            scss = { "stylelint" },
            c = { "cpplint" },
            cpp = { "cpplint" },
        }

        -- configure cpplint options
        lint.linters.cpplint.args = {
            "--filter=-legal/copyright,-build/include_order",
            "--linelength=100",
        }

        -- Set up autocommand for when to trigger linting
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })

        -- Key mapping for manual linting
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
