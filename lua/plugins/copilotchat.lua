return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest
			prompts = {
				Docs = {
					prompt = "/COPILOT_GENERATE Please add documentation comment for the selection. Do not contain any line number",
				},
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
