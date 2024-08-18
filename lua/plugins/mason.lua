return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	build = ":MasonUpdate",
	opts = {
		ensure_installed = {
			"lua-language-server",
			"yaml-language-server",
			"clangd",
			"ruff",
			"rust-analyzer",
			"ruff-lsp",
			"pyright",
			"neocmakelsp",
			"stylua",
		},
	},
}
