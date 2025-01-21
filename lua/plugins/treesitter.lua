return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdateSync" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"gitignore",
			"html",
			"http",
			"json",
			"lua",
			"luadoc",
			"rust",
			"toml",
			"typescript",
			"vimdoc",
			"yaml",
			"python",
			"c",
			"cpp",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
