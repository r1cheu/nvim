return {
	"folke/todo-comments.nvim",
	cmd = "TodoTelescope",
	event = "BufRead",
	keys = {
		{
			"<leader>fd",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},
	},
	config = function()
		require("todo-comments").setup({
			highlight = {
				pattern = [[.*<\(KEYWORDS\)\(rlchen\)\s*:]],
			},
			search = {
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS)\(rlchen\):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		})
	end,
}

-- TODO(rlchen) : Add support for more languages
