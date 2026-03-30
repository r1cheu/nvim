return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							local names = {}
							for _, client in ipairs(clients) do
								if client.name ~= "cspell_ls" then
									table.insert(names, client.name)
								end
							end
							if #names == 0 then
								return "🚫 No LSP"
							end
							return "🧠 " .. table.concat(names, ", ")
						end,
					},
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "lazy" },
		},
	},
	{
		"echasnovski/mini.files",
		opts = {
			mappings = {
				go_in_plus = "<CR>",
			},
		},
		config = function(_, opts)
			local mini_files = require("mini.files")
			mini_files.setup(opts)

			local ns_git = vim.api.nvim_create_namespace("mini_files_git")
			local ns_diag = vim.api.nvim_create_namespace("mini_files_diagnostic")

			-- git status symbols and highlights
			local git_status_map = {
				[" M"] = { symbol = "~", hl = "MiniDiffSignChange" },
				["M "] = { symbol = "~", hl = "MiniDiffSignChange" },
				["MM"] = { symbol = "~", hl = "MiniDiffSignChange" },
				["A "] = { symbol = "+", hl = "MiniDiffSignAdd" },
				["AM"] = { symbol = "+", hl = "MiniDiffSignAdd" },
				["??"] = { symbol = "?", hl = "MiniDiffSignAdd" },
				["D "] = { symbol = "-", hl = "MiniDiffSignDelete" },
				[" D"] = { symbol = "-", hl = "MiniDiffSignDelete" },
				["R "] = { symbol = "r", hl = "MiniDiffSignChange" },
			}

			local git_cache = {}
			local git_cache_time = 0

			local function update_git_status(cwd)
				local now = vim.uv.now()
				if now - git_cache_time < 2000 and git_cache[cwd] then
					return git_cache[cwd]
				end

				local git_root = vim.fs.root(cwd, ".git")
				if not git_root then
					return {}
				end

				local result = vim.system({ "git", "status", "--porcelain" }, { cwd = git_root }):wait()
				if result.code ~= 0 then
					return {}
				end

				local status = {}
				for line in (result.stdout or ""):gmatch("[^\n]+") do
					local code = line:sub(1, 2)
					local path = vim.fs.normalize(git_root .. "/" .. line:sub(4))
					status[path] = git_status_map[code]
				end

				git_cache[cwd] = status
				git_cache_time = now
				return status
			end

			local function apply_git_marks(buf_id, entries, cwd)
				vim.api.nvim_buf_clear_namespace(buf_id, ns_git, 0, -1)
				local statuses = update_git_status(cwd)
				for i, entry in ipairs(entries) do
					local s = statuses[entry.path]
					if s then
						vim.api.nvim_buf_set_extmark(buf_id, ns_git, i - 1, 0, {
							sign_text = s.symbol,
							sign_hl_group = s.hl,
							priority = 2,
						})
					end
				end
			end

			-- diagnostic severity symbols
			local diag_signs = {
				[vim.diagnostic.severity.ERROR] = { symbol = "E", hl = "DiagnosticSignError" },
				[vim.diagnostic.severity.WARN] = { symbol = "W", hl = "DiagnosticSignWarn" },
				[vim.diagnostic.severity.INFO] = { symbol = "I", hl = "DiagnosticSignInfo" },
				[vim.diagnostic.severity.HINT] = { symbol = "H", hl = "DiagnosticSignHint" },
			}

			local function apply_diag_marks(buf_id, entries)
				vim.api.nvim_buf_clear_namespace(buf_id, ns_diag, 0, -1)
				-- collect worst severity per file path
				local file_diags = {}
				for _, d in ipairs(vim.diagnostic.get()) do
					local path = vim.api.nvim_buf_get_name(d.bufnr)
					if not file_diags[path] or d.severity < file_diags[path] then
						file_diags[path] = d.severity
					end
				end
				for i, entry in ipairs(entries) do
					local sev = file_diags[entry.path]
					if sev and diag_signs[sev] then
						local sign = diag_signs[sev]
						vim.api.nvim_buf_set_extmark(buf_id, ns_diag, i - 1, 0, {
							sign_text = sign.symbol,
							sign_hl_group = sign.hl,
							priority = 3,
						})
					end
				end
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferUpdate",
				callback = function(args)
					local buf_id = args.data.buf_id

					local entries = {}
					for i = 1, vim.api.nvim_buf_line_count(buf_id) do
						local entry = MiniFiles.get_fs_entry(buf_id, i)
						if entry then
							table.insert(entries, entry)
						end
					end

					if #entries == 0 then
						return
					end

					-- derive directory from first entry's path
					local dir = vim.fn.fnamemodify(entries[1].path, ":h")
					apply_git_marks(buf_id, entries, dir)
					apply_diag_marks(buf_id, entries)
				end,
			})
		end,
	},
}
