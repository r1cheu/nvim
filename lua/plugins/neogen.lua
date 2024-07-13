return {
	"danymat/neogen",
	lazy = false,
	event = "BufRead",
	config = true,
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				python = {
					template = {
						annotation_convention = "numpydoc",
					},
				},
			},
		})
	end,
}
