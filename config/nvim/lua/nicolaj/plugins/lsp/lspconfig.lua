return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- Keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", function()
                vim.diagnostic.jump({ count = -1, float = true })
            end, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", function()
                vim.diagnostic.jump({ count = 1, float = true })
            end, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Python (Pyright)
        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pyright = {
                    analysis = {
                        typeCheckingMode = "basic",
                        diagnosticMode = "workspace",
                        inlayHints = {
                            variableTypes = true,
                            functionReturnTypes = true,
                        },
                    },
                },
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        -- Lua (lua_ls)
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                    completion = { callSnippet = "Replace" },
                },
            },
        })

        -- HTML
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                css = { validate = true, lint = { unknownAtRules = "ignore" } },
            },
        })

        -- JavaScript/TypeScript (ESLint via eslint_d)
        lspconfig["eslint"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            cmd = { "eslint_d", "--stdio" }, -- Faster linting
            settings = {
                experimental = { useFlatConfig = true },
            },
        })

        -- CSS/SCSS (Stylelint)
        lspconfig["stylelint_lsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "css", "scss", "tcss" }, -- Ignore JS files
            settings = {
                stylelint = {
                    configFile = ".stylelintrc.json", -- Optional: Explicit config path
                },
            },
        })

        -- Emmet (HTML/JSX only)
        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "javascriptreact", "typescriptreact" }, -- No CSS/JS
            init_options = {
                excludeLanguages = { "javascript", "typescript", "css" }, -- Block elsewhere
            },
        })

        -- C/C++
        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "clangd",
                "--offset-encoding=utf-16", -- Helps with some compatibility issues
                "--background-index", -- Index project in background for better code completion
                "--clang-tidy", -- Enable clang-tidy diagnostics
                "--header-insertion=iwyu", -- Insert missing headers
                "--completion-style=detailed", -- Detailed completion suggestions
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd", ".git"),
        })

        -- Nu
        lspconfig["nushell"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "nu" },
            cmd = {
                "nu",
                "--lsp",
            },
        })
    end,
}
