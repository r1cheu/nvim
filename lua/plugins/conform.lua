return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function() require("conform").format({ async = true }) end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            c = { "clang-format" },
            cpp = { "clang-format" },
            python = { "ruff_format", "ruff_organize_imports" },
            rust = { "rustfmt", lsp_format = "fallback" },
            lua = { "stylua" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            timeout_ms = 500,
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
