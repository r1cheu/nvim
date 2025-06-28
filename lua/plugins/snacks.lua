return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("snacks").setup({
			notifier = { enabled = true },
			words = { enabled = true },
			lazygit = {
				configure = false,
				win = {
					position = "float",
					width = 0.99,
					height = 0.99,
				},
			},
			terminal = {
				win = {
					position = "float",
					width = 0.5,
					height = 0,
					border = "rounded",
					wo = {
						winbar = "", -- hide terminal title
					},
				},
			},
			picker = {
				ui_select = true,
				formatters = {
					file = {
						filename_first = true,
					},
				},
				prompt = "   ",
			},
			input = {},
		})
	end,
}
