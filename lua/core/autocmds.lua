local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local utils = require("core.utils")

-- General Settings
local general = augroup("General Settings", { clear = true })

autocmd("BufEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.opt_local.spell = true
	end,
	group = general,
	desc = "Enable spell checking on specific filetypes",
})

autocmd("BufWinEnter", {
	callback = function(data)
		utils.open_help(data.buf)
	end,
	group = general,
	desc = "Redirect help to floating window",
})

autocmd("FileType", {
	group = general,
	pattern = {
		"grug-far",
		"help",
		"checkhealth",
		"copilot-chat",
		"Avante",
		"AvanteInput",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", {
			buffer = event.buf,
			silent = true,
			desc = "Quit buffer",
		})
	end,
})
