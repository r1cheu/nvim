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
map("n", "<leader>l", ":Lazy<cr>", { desc = "Lazy" })

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

-- quit
map("n", "<leader>qq", ":qa<cr>", { desc = "Quit all" })

--[[ Lazygit
map("n", "<leader>gg", function()
	local term = require("toggleterm.terminal").Terminal
	local lazygit = term:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "none",
			-- fullscreen
			width = vim.o.columns,
			height = vim.o.lines,
		},
	})
	lazygit:toggle()
end, { desc = "Lazygit" }) ]]
--

map("n", "<leader>gd", ":Copilot disable<cr>", { desc = "disable Copilot" })

local wk = require("which-key")

-- Coding
wk.add({
	{
		mode = { "n", "v" },
		{ "<leader>g", group = "code" },
		{ "<leader>gg", group = "CopilotChat" },
		{ "<leader>gn", group = "neogen" },
		{ "<leader>gh", group = "git" },
		{ "<leader>gC", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
		{ "<leader>gd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
		{ "<leader>gl", "<cmd>LspInfo<cr>", desc = "LSP Info" },
		{ "<leader>ga", vim.lsp.buf.code_action, desc = "Code Action" },
		{ "<leader>gr", vim.lsp.buf.rename, desc = "Rename" },
		{ "<leader>gm", "<cmd>Mason<cr>", desc = "Mason" },
		{ "<leader>ggd", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs" },
		{ "<leader>ggf", "<cmd>CopilotChatFix<cr>", desc = "Fix the Code" },
		{ "<leader>ggo", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code" },
		{ "<leader>ggt", "<cmd>CopilotChatTests<cr>", desc = "Generate unitest" },
		{ "<leader>gge", "<cmd>CopilotChatExplain<cr>", desc = "Explain the Code" },
		{ "<leader>gnc", "<cmd>lua require('neogen').generate({type='class'})<cr>", desc = "Generate Class Docs" },
		{ "<leader>gnf", "<cmd>lua require('neogen').generate()<cr>", desc = "Generate Function Docs" },
	},
})

wk.add({
	{ mode = "n", "<leader>cm", "<cmd>Mason<cr>", hidden = true },
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

-- tabs
wk.add({
	mode = "n",
	{ "<leader><tab>", group = "tabs" },
	{ "<leader><tab>l", "<cmd>tablst<cr>", desc = "Last Tab" },
	{ "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "First Tab" },
	{ "<leader><tab><tab>", "<cmd>tabnew<cr>", desc = "New Tab" },
	{ "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Next Tab" },
	{ "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close Tab" },
	{ "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Previous Tab" },
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
