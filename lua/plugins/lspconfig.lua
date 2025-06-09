return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				lsp = { auto_attact = true },
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		"Bilal2453/luvit-meta",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_registry = require("mason-registry")
		require("lspconfig.ui.windows").default_options.border = "rounded"

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

		-- Run setup for no_config_servers
		local no_config_servers = {
			"docker_compose_language_service",
			"dockerls",
			"jsonls",
			"yamlls",
			"ruff",
			"clangd",
			"bashls",
			"taplo",
		}
		for _, server in pairs(no_config_servers) do
			lspconfig[server].setup({})
		end

		lspconfig.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--offset-encoding=utf-16",
				"--header-insertion=iwyu",
			},
		})

		--Python
		lspconfig.pyright.setup({
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		})
		-- Lua
		lspconfig.lua_ls.setup({
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if not vim.uv.fs_stat(path .. "/.luarc.json") and not vim.uv.fs_stat(path .. "/.luarc.jsonc") then
					client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							workspace = {
								checkThirdParty = false,
								library = vim.api.nvim_get_runtime_file("", true),
							},
						},
					})

					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end
				return true
			end,
		})

		-- Rust
		lspconfig.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
					cargo = {
						loadOutDirsFromCheck = true,
					},
				},
			},
		})
		-- CMAKE
		lspconfig.cmake.setup({
			cmd = { "cmake-language-server" },
			filetypes = { "cmake" },
		})

		--DJANGO
		lspconfig.djlsp.setup({
			cmd = { "djlsp" },
		})
	end,
}
