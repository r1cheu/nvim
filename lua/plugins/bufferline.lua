return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			mode = "buffers",
			diagnostics = false,
			always_show_bufferline = false,
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			right_mouse_command = function(n)
				Snacks.bufdelete(n)
			end,
		},
	},
}
