return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local mason_dap = require("mason-nvim-dap")

        -- Configure mason-nvim-dap
        mason_dap.setup({
            ensure_installed = { "codelldb", "debugpy" },
            automatic_installation = true,
            handlers = {},
        })

        -- Set up Python debugging (using the Mason-installed debugpy)
        require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

        -- Removed the problematic test_runners configuration

        -- Python test debugging keymaps
        vim.keymap.set("n", "<leader>dpm", function()
            require("dap-python").test_method()
        end, { desc = "Debug Python Test Method" })
        vim.keymap.set("n", "<leader>dpc", function()
            require("dap-python").test_class()
        end, { desc = "Debug Python Test Class" })
        vim.keymap.set("n", "<leader>dps", function()
            require("dap-python").debug_selection()
        end, { desc = "Debug Python Selection" })

        -- Set up C/C++ debugging
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
            {
                name = "Attach to process",
                type = "codelldb",
                request = "attach",
                pid = require("dap.utils").pick_process,
                args = {},
            },
        }

        -- Use the same configurations for C++
        dap.configurations.cpp = dap.configurations.c

        -- Configure DAP UI
        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = {
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    size = 10,
                    position = "bottom",
                },
            },
        })

        -- Connect DAP UI to DAP events
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Configure virtual text
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            all_frames = true,
            virt_text_pos = "eol",
            all_references = true,
        })

        -- Keymappings
        vim.keymap.set("n", "<leader>db", function()
            dap.toggle_breakpoint()
        end, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Conditional Breakpoint" })
        vim.keymap.set("n", "<leader>dc", function()
            dap.continue()
        end, { desc = "Start/Continue Debugging" })
        vim.keymap.set("n", "<leader>dt", function()
            dapui.toggle()
        end, { desc = "Toggle Debug UI" })
        vim.keymap.set("n", "<leader>dn", function()
            dap.step_over()
        end, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>di", function()
            dap.step_into()
        end, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", function()
            dap.step_out()
        end, { desc = "Step Out" })
        vim.keymap.set("n", "<leader>dl", function()
            dap.run_last()
        end, { desc = "Run Last Debug Configuration" })
        vim.keymap.set("n", "<leader>dx", function()
            dap.terminate()
        end, { desc = "Terminate Debug Session" })
        vim.keymap.set("n", "<leader>dv", function()
            require("dap.ui.widgets").hover()
        end, { desc = "Variables Hover" })
    end,
}
