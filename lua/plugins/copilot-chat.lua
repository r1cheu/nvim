return {
	"CopilotC-Nvim/CopilotChat.nvim",
	cmd = "CopilotChat",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	},
	keys = {
		{
			"<leader>aA",
			function()
				return require("CopilotChat").toggle()
			end,
			desc = "Toggle",
			mode = { "n", "v" },
		},
		{
			"<leader>ax",
			function()
				return require("CopilotChat").reset()
			end,
			desc = "Clear",
			mode = { "n", "v" },
		},
		{
			"<leader>aq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end,
			desc = "Quick Chat",
			mode = { "n", "v" },
		},
		{
			"<leader>ac",
			":CopilotChatCommit<cr>",
			desc = "Commit",
			mode = { "n", "v" },
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		require("CopilotChat").setup({
			model = "claude-4-sonnet",
			auto_insert_mode = true,
			chat_autocomplete = false,
			show_help = false,
			show_folds = false,
			question_header = " rlchen ",
			answer_header = " Copilot ",
			window = {
				layout = "float",
				relative = "editor",
				row = 0,
				col = vim.o.columns - 80,
				width = 80,
				height = vim.o.lines - 2,
				border = "rounded",
			},
			mappings = {
				close = {
					insert = "C-q",
				},
			},
			selection = function(source)
				local select = require("CopilotChat.select")
				return select.visual(source) or select.buffer(source)
			end,
		})
	end,
}
