return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	config = function()
		vim.g.disable_autoformat = false
		require("conform").setup({
			formatters_by_ft = {
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				sh = { "shfmt" },
				toml = { "taplo" },
				yaml = { "prettier" },
				cpp = { "clang_format" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" }
					else
						return { "isort", "black" }
					end
				end,
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},

			format_after_save = function()
				if vim.g.disable_autoformat then
					return
				else
					return { lsp_fallback = true }
				end
			end,

			formatters = {
				clang_format = {
					command = "clang-format",
					args = { "-assume-filename", "$FILENAME" },
				},
				ruff = {
					command = "ruff format",
					args = { "--config", "~/.config/nvim/ruff.toml", "$FILENAME" },
				},

				black = {
					command = "black",
				},
				codespell = {
					command = "codespell",
					args = { "-L", "name", "$FILENAME" },
				},
				--                goimports_reviser = {
				--                   command = "goimports-reviser",
				--                    args = { "-output", "stdout", "$FILENAME" },
			},
		})

		-- Override prettier's default indent type
		--        require("conform").formatters.prettier = {
		--           prepend_args = { "--tab-width", "4" },
		--        }

		-- Toggle format on save
		vim.api.nvim_create_user_command("ConformToggle", function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
			print("Conform " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
		end, {
			desc = "Toggle format on save",
		})
	end,
}
