return {
	"theHamsta/nvim-dap-virtual-text",
	event = "VeryLazy",
	depencencises = {
		"mfussenegger/nvim-dap",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({})
	end,
}
