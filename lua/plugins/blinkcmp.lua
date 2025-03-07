---@diagnostic disable: missing-fields
return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	version = "v0.*",
	config = function()
		local is_enabled = function()
			local disabled_ft = {
				"TelescopePrompt",
				"grug-far",
			}
			return not vim.tbl_contains(disabled_ft, vim.bo.filetype)
				and vim.b.completion ~= false
				and vim.bo.buftype ~= "prompt"
		end

		require("blink.cmp").setup({
			enabled = is_enabled,
			appearance = {
				kind_icons = {
					Copilot = "",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						opts = {
							kind_name = "CP",
						},
					},
				},
			},
			keymap = {
				preset = "enter",
				["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			},
			completion = {
				menu = {
					scrollbar = false,
					auto_show = is_enabled,
					border = {
						{ "󱐋", "WarningMsg" },
						"─",
						"╮",
						"│",
						"╯",
						"─",
						"╰",
						"│",
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = {
							{ "", "DiagnosticHint" },
							"─",
							"╮",
							"│",
							"╯",
							"─",
							"╰",
							"│",
						},
					},
				},
			},
		})
	end,
}
