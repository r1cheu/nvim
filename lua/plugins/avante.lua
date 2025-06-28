return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	opts = {
		provider = "deepseek_r1",
		auto_suggestions_provider = "deepseek_v3",
		-- cursor_applying_provider = "ollama",
		-- behaviour = {
		-- 	enable_cursor_planning_mode = true,
		-- },
		providers = {
			ollama = {
				endpoint = "http://10.10.9.2:11434",
				model = "qwen3:8b",
				extra_request_body = {
					options = {
						temperature = 0.7,
						top_p = 0.8,
						min_p = 0,
						top_k = 20,
						think = false,
						num_ctx = 32768,
						keep_alive = "-1",
					},
				},
			},
			sonnet4 = {
				__inherited_from = "openai",
				api_key_name = "OPENROUTER_API_KEY",
				endpoint = "https://openrouter.ai/api/v1",
				model = "anthropic/claude-sonnet-4",
				extra_request_body = {
					options = {
						max_token = 64000,
					},
				},
			},
			deepseek_v3 = {
				__inherited_from = "openai",
				api_key_name = "DEEPSEEK_API_KEY",
				endpoint = "https://api.deepseek.com/v1",
				model = "deepseek-chat",
				extra_request_body = {
					options = {
						max_tokens = 8192,
					},
				},
			},
			deepseek_r1 = {
				__inherited_from = "openai",
				api_key_name = "DEEPSEEK_API_KEY",
				endpoint = "https://api.deepseek.com/v1",
				model = "deepseek-reasoner",
				extra_request_body = {
					options = {
						max_tokens = 32768,
					},
				},
			},
			qwen3 = {
				__inherited_from = "openai",
				api_key_name = "QWEN_API_KEY",
				endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1/",
				model = "qwen3-235b-a22b",
				extra_request_body = {
					options = {
						max_tokens = 16384,
					},
				},
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
