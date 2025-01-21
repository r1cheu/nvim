return {
	"neovim/nvim-lspconfig",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		"Bilal2453/luvit-meta",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"smiteshp/nvim-navic",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_registry = require("mason-registry")
		require("lspconfig.ui.windows").default_options.border = "rounded"
		lspconfig.lua_ls.setup({})
		lspconfig.clangd.setup({
			cmd = { "clangd", "--background-index=0", "--clang-tidy" },
		})
		lspconfig.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})
		lspconfig.ruff.setup({})
		lspconfig.pyright.setup({
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})
		lspconfig.cmake.setup({
			cmd = { "cmake-language-server" },
			filetypes = { "cmake" },
		})
	end,
}
