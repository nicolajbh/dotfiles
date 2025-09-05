return {
	"neovim/nvim-lspconfig",
	config = function()
		require("mason").setup({
			registries = { "github:crashdummyy/mason-registry", "github:mason-org/mason-registry" },
		})
		require("mason-lspconfig").setup()
		require("roslyn").setup()
	end,
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
		"seblyng/roslyn.nvim",
	},
}
