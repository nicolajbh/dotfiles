vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Increment number" }) -- increment

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open current buffer in new tab

-- Dynamic tab navigation functionality
keymap.set("n", "<leader>gt", function()
    local tabs = vim.fn.gettabinfo()
    if #tabs == 0 then
        vim.notify("No tabs open", vim.log.levels.INFO)
        return
    end

    -- Create a temporary keymapping for each tab
    for i, tab in ipairs(tabs) do
        local tab_num = tab.tabnr

        -- Get buffer info for better tab identification
        local buflist = vim.fn.tabpagebuflist(tab.tabnr)
        local bufname = buflist and #buflist > 0 and vim.fn.bufname(buflist[1]) or "[No Name]"
        if bufname == "" then
            bufname = "[No Name]"
        end

        -- Extract filename without path
        local filename = bufname:match("([^/\\]+)$") or bufname
        local current = tab.tabnr == vim.fn.tabpagenr() and "*" or ""

        -- Create a description that which-key will display
        local desc = current .. filename

        -- Set the mapping - which-key will automatically pick this up
        keymap.set("n", "<leader>gt" .. i, function()
            vim.cmd("tabn " .. tab_num)
            -- Clean up after selection
            for j = 1, #tabs do
                pcall(function()
                    vim.keymap.del("n", "<leader>gt" .. j)
                end)
            end
        end, { desc = desc, silent = true })
    end

    -- Let which-key do its thing
    vim.cmd("WhichKey <leader>gt")

    -- Clean up if no selection is made after a delay
    vim.defer_fn(function()
        for i = 1, #tabs do
            pcall(function()
                vim.keymap.del("n", "<leader>gt" .. i)
            end)
        end
    end, 5000)
end, { desc = "Go to tab" })

-- Toggle between dark (dragon) and light (lotus) Kanagawa themes
keymap.set("n", "<leader>tt", function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
        vim.notify("Switched to light theme (lotus)")
    else
        vim.o.background = "dark"
        vim.notify("Switched to dark theme (dragon)")
    end
end, { desc = "Toggle between light and dark themes" })
