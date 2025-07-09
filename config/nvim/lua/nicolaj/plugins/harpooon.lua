return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        local keymap = vim.keymap
        keymap.set("n", "<leader>hm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon Menu" })

        keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Harpoon add file" })
        keymap.set("n", "<leader>h1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon File 1" })
        keymap.set("n", "<leader>h2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon File 2" })
        keymap.set("n", "<leader>h3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon File 3" })
        keymap.set("n", "<leader>h4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon File 4" })

        keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
        end, { desc = "Harpoon Next File" })
        keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
        end, { desc = "Harpoon Previous File" })
    end,
}
