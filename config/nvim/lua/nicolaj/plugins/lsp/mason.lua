return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "pyright",
                "lua_ls",
                "html",
                "cssls",
                "ts_ls",
                "emmet_ls",
                "stylelint_lsp",
                "clangd",
            },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                -- Formatters
                "stylua", -- Lua formatter
                "prettier", -- JSON formatter

                -- Linters & Formatters
                "ruff", -- Fast Python linter and formatter
                "eslint_d",

                -- C dev tools
                "clang-format", -- C code formatter
                "cpplint", -- C/C++ linter
                "codelldb", -- debugger for c
            },
            auto_update = true,
            run_on_start = true,
        })
    end,
}
