return {
	{
		"scottmckendry/cyberdream.nvim",
		dev = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				terminal_colors = false,
				theme = {
					highlights = {
						LineNr = { fg = "#ffffff" },
						CursorLineNr = { fg = "#26C9FC" },
					},
				},
			})

			vim.cmd("colorscheme cyberdream")
		end,
	},
}
