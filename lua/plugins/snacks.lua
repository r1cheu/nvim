return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = "\u{f002} ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = "\u{f15b} ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = "\u{f0b0} ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = "\u{f017} ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = "\u{f013} ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon = "\u{f126} ", key = "l", desc = "Lazygit", action = ":lua Snacks.lazygit()" },
					{ icon = "\u{f0e2} ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "\u{f0772} ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = "\u{f011} ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					auto_close = true,
				},
			},
			win = {
				input = {
					keys = {
						["<a-s>"] = { "flash", mode = { "n", "i" } },
						["s"] = { "flash" },
					},
				},
			},
			actions = {
				flash = function(picker)
					require("flash").jump({
						pattern = "^",
						label = { after = { 0, 0 } },
						search = {
							mode = "search",
							exclude = {
								function(win)
									return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
								end,
							},
						},
						action = function(match)
							local idx = picker.list:row2idx(match.pos[1])
							picker.list:_move(idx, true, true)
						end,
					})
				end,
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		dim = { enabled = true },
		zen = { enabled = true },
		scratch = { enabled = true },
		terminal = { enabled = true },
		lazygit = { enabled = true },
		gitbrowse = { enabled = true },
		image = { enabled = true },
		animate = { enabled = true },
		toggle = { enabled = true },
		rename = { enabled = true },
	},
	-- keymaps are defined in keymaps.lua
}
