local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.signcolumn = "yes"
opt.winborder = "rounded"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")

-- Set Python path
vim.g.python3_host_prog = "/usr/local/bin/python3"

opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Change working directory
vim.api.nvim_create_user_command("Setwd", function()
	vim.cmd("cd " .. vim.fn.expand("%:p:h"))
end, {})

-- theme
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.g.SCHEME then
			pcall(vim.cmd.colorscheme, vim.g.SCHEME)
		else
			vim.cmd.colorscheme("default")
		end
	end,
})

-- Set highlight on search, but clear on <Esc>
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- lsp set up
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float) -- see error
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
