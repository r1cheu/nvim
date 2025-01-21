local utils = require("core.utils")
local snacks = require("snacks")

local map = function(modes, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, options)
	end
end

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- lazy
map("n", "<leader>L", ":Lazy<cr>", { desc = "Lazy" })

--keywordprg
map("n", "<leader>K", ":norm! K<cr>", { desc = "Keywordprg" })

-- Clear search with <esc>
map("n", "<esc>", ":noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<leader>qq", ":qa<cr>", { desc = "Quit all" })
map("n", "<leader>wj", ":w<cr>", { desc = "write file" })
map("n", "<leader>wq", ":wq<cr>", { desc = "write and quit" })

map({ "n", "t" }, "<C-\\>", function()
	snacks.terminal()
end, { desc = "Toggle Terminal" })
map("n", "<leader>gg", function()
	snacks.lazygit()
end, { desc = "Lazygit" })
local wk = require("which-key")

-- Coding
wk.add({
	{
		mode = { "n", "v" },
		{ "<leader>g", group = "code" },
		{ "<leader>gn", group = "neogen" },
		{ "<leader>gh", group = "git" },
		{ "<leader>gd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
		{ "<leader>gl", "<cmd>LspInfo<cr>", desc = "LSP Info" },
		{ "<leader>gj", vim.lsp.buf.code_action, desc = "Code Action" },
		{ "<leader>gr", vim.lsp.buf.rename, desc = "Rename" },
		{ "<leader>gm", "<cmd>Mason<cr>", desc = "Mason" },
		{ "<leader>gnc", "<cmd>lua require('neogen').generate({type='class'})<cr>", desc = "Generate Class Docs" },
		{ "<leader>gnf", "<cmd>lua require('neogen').generate({type='func'})<cr>", desc = "Generate Function Docs" },
		{
			"<leader>gnm",
			"<cmd>lua require('neogen').generate({type='file'})<cr>",
			desc = "Generate Module（File）Docs",
		},
		{ "<leader>gnt", "<cmd>lua require('neogen').generate({type='type'})<cr>", desc = "Generate Type" },
	},
})

wk.add({
	{
		mode = "n",
		{
			"gd",
			function()
				require("telescope.builtin").lsp_definitions({ reuse_win = true })
			end,
			desc = "Goto Definition",
		},
		{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Goto References" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		{
			"gI",
			function()
				require("telescope.builtin").lsp_implementations({ reuse_win = true })
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
			end,
			desc = "Goto Type Definition",
		},
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
	},
})

-- Debugging
wk.add({
	mode = { "n" },
	{ "<leader>d", group = "debug" },
	{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
	{ "<leader>dr", "<cmd>DapContinue<cr>", desc = "Start or continue the debugger" },
	{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "StepInto" },
	{ "<leader>dn", "<cmd>DapStepOver<cr>", desc = "StepOver" },
	{ "<leader>do", "<cmd>DapStepOut<cr>", desc = "StepOut" },
	{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
})

-- windows
wk.add({
	mode = "n",
	{ "<leader>w", group = "windows" },
	{ "<leader>ww", "<C-W>p", desc = "Other window" },
	{ "<leader>wd", "<C-W>c", desc = "Delete window" },
	{ "<leader>w-", "<C-W>s", desc = "Split window below" },
	{ "<leader>w|", "<C-W>v", desc = "Split window right" },
	{ "<leader>-", "<C-W>s", desc = "Split window below" },
	{ "<leader>|", "<C-W>v", desc = "Split window right" },
})

-- move between windows
wk.add({
	mode = "n",
	{ "<C-h>", "<C-w>h", desc = "Go to left window", hidden = true },
	{ "<C-j>", "<C-w>j", desc = "Go to lower window", hidden = true },
	{ "<C-k>", "<C-w>k", desc = "Go to upper window", hidden = true },
	{ "<C-l>", "<C-w>l", desc = "Go to right window", hidden = true },
})

-- Buffers
wk.add({
	mode = "n",
	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer", hidden = true },
	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer", hidden = true },
	{ "<leader>b", group = "buffer" },
})

-- Telescope
wk.add({
	mode = "n",
	{ "<leader>f", group = "file" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Fuzzy find recent files" },
	{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string in CWD" },
	{ "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor in CWD" },
})

-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
	require("avante.api").edit()
	local code_bufnr = vim.api.nvim_get_current_buf()
	local code_winid = vim.api.nvim_get_current_win()
	if code_bufnr == nil or code_winid == nil then
		return
	end
	vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
	-- Optionally set the cursor position to the end of the input
	vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
	-- Simulate Ctrl+S keypress to submit
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

wk.add({
	{ "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
	{
		mode = { "n", "v" },
		{
			"<leader>ag",
			function()
				require("avante.api").ask({ question = avante_grammar_correction })
			end,
			desc = "Grammar Correction(ask)",
		},
		{
			"<leader>ak",
			function()
				require("avante.api").ask({ question = avante_keywords })
			end,
			desc = "Keywords(ask)",
		},
		{
			"<leader>al",
			function()
				require("avante.api").ask({ question = avante_code_readability_analysis })
			end,
			desc = "Code Readability Analysis(ask)",
		},
		{
			"<leader>ao",
			function()
				require("avante.api").ask({ question = avante_optimize_code })
			end,
			desc = "Optimize Code(ask)",
		},
		{
			"<leader>am",
			function()
				require("avante.api").ask({ question = avante_summarize })
			end,
			desc = "Summarize text(ask)",
		},
		{
			"<leader>an",
			function()
				require("avante.api").ask({ question = avante_translate })
			end,
			desc = "Translate text(ask)",
		},
		{
			"<leader>ax",
			function()
				require("avante.api").ask({ question = avante_explain_code })
			end,
			desc = "Explain Code(ask)",
		},
		{
			"<leader>ac",
			function()
				require("avante.api").ask({ question = avante_complete_code })
			end,
			desc = "Complete Code(ask)",
		},
		{
			"<leader>ad",
			function()
				require("avante.api").ask({ question = avante_add_docstring })
			end,
			desc = "Docstring(ask)",
		},
		{
			"<leader>ab",
			function()
				require("avante.api").ask({ question = avante_fix_bugs })
			end,
			desc = "Fix Bugs(ask)",
		},
		{
			"<leader>au",
			function()
				require("avante.api").ask({ question = avante_add_tests })
			end,
			desc = "Add Tests(ask)",
		},
	},
})

wk.add({
	{ "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
	{
		mode = { "v" },
		{
			"<leader>aG",
			function()
				prefill_edit_window(avante_grammar_correction)
			end,
			desc = "Grammar Correction",
		},
		{
			"<leader>aK",
			function()
				prefill_edit_window(avante_keywords)
			end,
			desc = "Keywords",
		},
		{
			"<leader>aO",
			function()
				prefill_edit_window(avante_optimize_code)
			end,
			desc = "Optimize Code(edit)",
		},
		{
			"<leader>aC",
			function()
				prefill_edit_window(avante_complete_code)
			end,
			desc = "Complete Code(edit)",
		},
		{
			"<leader>aD",
			function()
				prefill_edit_window(avante_add_docstring)
			end,
			desc = "Docstring(edit)",
		},
		{
			"<leader>aB",
			function()
				prefill_edit_window(avante_fix_bugs)
			end,
			desc = "Fix Bugs(edit)",
		},
		{
			"<leader>aU",
			function()
				prefill_edit_window(avante_add_tests)
			end,
			desc = "Add Tests(edit)",
		},
	},
})
