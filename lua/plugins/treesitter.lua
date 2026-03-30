return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "cpp", "python", "rust",
                "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline",
                "bash", "json", "yaml", "toml",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
