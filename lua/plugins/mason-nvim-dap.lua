return {
	"jay-babu/mason-nvim-dap.nvim",
	event = "VeryLazy",
	dependences = {
		"mfussenegger/nvim-dap",
		"williamboman/mason.nvim",
	},
	opts = {
		handlers = {},
		ensure_installed = {
			"codelldb",
		},
	},
}
