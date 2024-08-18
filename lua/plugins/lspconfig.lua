return {
	"neovim/nvim-lspconfig",
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
		"hrsh7th/cmp-nvim-lsp",
		"smiteshp/nvim-navic",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- Diagnostics
		vim.diagnostic.config({
			signs = true,
			underline = true,
			update_in_insert = true,
			virtual_text = {
				source = "if_many",
				prefix = "●",
			},
		})

		-- Go

		-- Lua
		require("lspconfig").lua_ls.setup({})
		require("lspconfig").clangd.setup({
			cmd = { "clangd", "--query-driver=/usr/sbin/c++" },
			capabilities = capabilities,
		})
		require("lspconfig").rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})
		require("lspconfig").ruff.setup({
			capabilities = capabilities,
		})
		require("lspconfig").ruff_lsp.setup({
			capabilities = capabilities,
		})

		require("lspconfig").pyright.setup({
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})

		require("lspconfig").taplo.setup({
			capabilities = capabilities,
		})
		require("lspconfig").neocmake.setup({
			cmd = { "neocmakelsp", "--stdio" },
			capabilities = capabilities,
		})
	end,
}
