return {
    -- mason: package manager for LSP servers, formatters, etc.
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "clang-format",
                "stylua",
                "prettier",
                "ruff",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local registry = require("mason-registry")
            registry.refresh(function()
                for _, name in ipairs(opts.ensure_installed) do
                    local pkg = registry.get_package(name)
                    if not pkg:is_installed() then
                        pkg:install()
                    end
                end
            end)
        end,
    },

    -- mason-lspconfig: auto install & enable LSP servers
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "clangd",
                "pyright",
                "lua_ls",
            },
            automatic_enable = true,
        },
    },

    -- nvim-lspconfig: LSP configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            -- pass blink.cmp capabilities to all LSP servers
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            -- clangd: use pixi version (22.x) to avoid crash in mason's 21.x
            vim.lsp.config("clangd", {
                cmd = { "/home/rlchen/.pixi/bin/clangd" },
            })

            -- lua_ls: configure for Neovim Lua development
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    },
                },
            })

            -- LSP keymaps are defined in keymaps.lua
        end,
    },

    -- blink.cmp: auto-completion
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "enter" },
            appearance = { nerd_font_variant = "mono" },
            completion = {
                menu = { border = "rounded" },
                documentation = { auto_show = true, window = { border = "rounded" } },
            },
            signature = { window = { border = "rounded" } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    snippets = {
                        opts = {
                            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                        },
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- copilot: AI code completion (ghost text, not in blink menu)
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<M-e>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                sh = false,
                bash = false,
                zsh = false,
                fish = false,
                ["."] = false,
            },
        },
    },

    -- blink.pairs: auto-pairing + rainbow brackets
    {
        "saghen/blink.pairs",
        version = "*",
        dependencies = { "saghen/blink.download" },
        event = "InsertEnter",
        ---@module 'blink.pairs'
        ---@type blink.pairs.Config
        opts = {},
    },
}
