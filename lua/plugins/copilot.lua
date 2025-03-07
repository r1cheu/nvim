return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = false,
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				yaml = true,
				help = true,
				["grug-far"] = false,
			},
		})
	end,
}
