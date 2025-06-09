return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	config = function()
		vim.g.autoformat = true
		require("conform").setup({
			formatters_by_ft = {
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				toml = { "taplo", "pyproject-fmt" },
				yaml = { "prettier" },
				cpp = { "clang-format" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				cmake = { "cmake_format" },
				djangohtml = { "djlint" },
			},

			format_after_save = function()
				if not vim.g.autoformat then
					return
				else
					return { lsp_format = "fallback" }
				end
			end,
			formatters = {
				clang_format = {
					command = "clang-format",
					args = {
						"-assume-filename",
						"$FILENAME",
					},
				},
			},
		})
	end,
}
