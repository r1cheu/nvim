return {
	"danymat/neogen",
	lazy = false,
	event = "BufRead",
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
