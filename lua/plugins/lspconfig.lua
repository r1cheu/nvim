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
        local mason_registry = require("mason-registry")

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
        require("lspconfig").lua_ls.setup({
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
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
        require("lspconfig").clangd.setup({
            cmd = { "clangd", "--background-index", },
            filetypes = { "c", "cpp", "objc", "objcpp" },
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
        require("lspconfig").pyright.setup({
            capabilities = capabilities,
        })
        require("lspconfig").ruff.setup({
            capabilities = capabilities,
        })
        require("lspconfig").ruff_lsp.setup({
            capabilities = capabilities,
        })
    end,
}
