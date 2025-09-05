return {
	"echasnovski/mini.pick",
	version = false,
	dependencies = {
		"echasnovski/mini.extra",
	},
	config = function()
		local pick = require("mini.pick")
		pick.setup()

		require("mini.extra").setup()

    -- stylua: ignore start
    local default_colorschemes = { "blue", "darkblue", "default", "delek", "desert", "elflord", "evening", "habamax", "industry", "koehler", "lunaperche", "morning", "murphy", "pablo", "peachpuff", "quiet", "retrobox", "ron", "shine", "slate", "sorbet", "torte", "unokai", "wildcharm", "zaibatsu", "zellner", }
		-- stylua: ignore end

		-- Find files
		vim.keymap.set("n", "<leader>ff", function()
			pick.builtin.files({
				tool = "rg",
				tool_args = { "--files", "--hidden", "--glob", "!.git/*" },
			})
		end, { desc = "Find files" })

		-- Buffers
		vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "Find buffers" })

		-- Live grep
		vim.keymap.set("n", "<leader>fg", function()
			pick.builtin.grep_live({
				tool = "rg",
				tool_args = { "--vimgrep", "--hidden", "--glob", "!.git/*" },
			})
		end, { desc = "Live grep" })

		-- Diagnostics
		vim.keymap.set("n", "<leader>fd", function()
			require("mini.extra").pickers.diagnostic()
		end, { desc = "Find diagnostics" })

		-- LSP symbols
		vim.keymap.set("n", "<leader>ws", function()
			require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
		end, { desc = "Workspace symbols" })

		vim.keymap.set("n", "<leader>ds", function()
			require("mini.extra").pickers.lsp({ scope = "document_symbol" })
		end, { desc = "Document symbols" })

		-- Help tags
		vim.keymap.set("n", "<leader>fh", function()
			pick.builtin.help()
		end, { desc = "Seach help tags" })

		-- Zoxide
		vim.keymap.set("n", "<leader>fz", function()
			pick.start({ source = { items = vim.fn.systemlist("zoxide query -l") } })
		end, { desc = "Zoxide" })

		-- Colorscheme
		vim.keymap.set("n", "<C-n>", function()
			local all_colorschemes = vim.fn.getcompletion("", "color")
			pick.start({
				source = {
					items = vim.tbl_filter(function(color)
						return not vim.tbl_contains(default_colorschemes, color)
					end, all_colorschemes),
					choose = function(selected)
						vim.g.SCHEME = selected
						vim.cmd.colorscheme(selected)
					end,
				},
			})
		end, { desc = "Pick colorscheme" })

		-- Marks
		vim.keymap.set("n", "<leader>fm", function()
			require("mini.extra").pickers.marks()
		end, { desc = "Pick marks" })

		-- References
		vim.keymap.set("n", "<leader>fr", function()
			require("mini.extra").pickers.lsp({ scope = "references" })
		end, { desc = "LSP references" })
	end,
}
