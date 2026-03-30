return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>s", group = "search" },
            { "<leader>b", group = "buffer" },
            { "<leader>c", group = "code" },
            { "<leader>u", group = "ui" },
            { "<leader>w", group = "window" },
        },
    },
}
