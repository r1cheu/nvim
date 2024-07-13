return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		defaults = {
			mode = { "n", "v" },
			["<leader>b"] = { name = "+buffer" },
			["<leader>c"] = { name = "+code" },
			["<leader>cn"] = { name = "neogen docstring" },
			["<leader>cc"] = { name = "copilot chat" },
			["<leader>e"] = { name = "+explorer" },
			["<leader>f"] = { name = "+file/find" },
			["<leader>g"] = { name = "+git" },
			["<leader>o"] = { name = "+obsidian" },
			["<leader>r"] = { name = "+run" },
			["<leader>s"] = { name = "+search" },
			["<leader>w"] = { name = "+windows" },
			["<leader>x"] = { name = "+diagnostics/quickfix" },
			["<leader><Tab>"] = { name = "+tabs" },
			["<leader>d"] = { name = "+debug" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
