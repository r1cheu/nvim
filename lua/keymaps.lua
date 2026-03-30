local map = vim.keymap.set

-- general
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>ww", "<cmd>w<cr>", { desc = "Save" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- window
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>w-", "<cmd>split<cr>", { desc = "Split below" })
map("n", "<leader>w\\", "<cmd>vsplit<cr>", { desc = "Split right" })
map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close window" })

-- buffer
map("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- editing
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- top-level
map("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>e", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "File Explorer" })
map("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })

-- lazy & mason
map("n", "<leader>gl", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>gm", "<cmd>Mason<cr>", { desc = "Mason" })

-- git
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
map({ "n", "v" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse" })

map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
map({ "n", "x" }, "<leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep Word" })
map("n", "<leader>fb", function()
	Snacks.picker.lines()
end, { desc = "Buffer Lines" })
map("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help Pages" })
map("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>fR", function()
	Snacks.picker.resume()
end, { desc = "Resume" })
map("n", "<leader>ff", function()
	require("grug-far").open()
end, { desc = "Find and Replace" })
map("v", "<leader>ff", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Find and Replace (Current Word)" })

-- lsp navigation (via snacks picker)
map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
map("n", "gr", function()
	Snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })
map("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
map("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })

-- buffer
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>b,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>b.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>bS", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- ui
map("n", "<leader>uC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })
map("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
map("n", "<leader>uz", function()
	Snacks.zen()
end, { desc = "Toggle Zen Mode" })
map("n", "<leader>uZ", function()
	Snacks.zen.zoom()
end, { desc = "Toggle Zoom" })
map("n", "<c-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })

-- word references jump
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

-- lsp (only active when a server is attached)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { buffer = buf, desc = "Hover" })
		map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
		map({ "n", "v" }, "g.", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action" })
		map("n", "<leader>cd", vim.diagnostic.open_float, { buffer = buf, desc = "Line Diagnostics" })
		map("n", "<leader>cdd", function()
			local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
			if #diagnostics == 0 then
				vim.notify("No diagnostics on current line", vim.log.levels.INFO)
				return
			end
			local msgs = {}
			for _, d in ipairs(diagnostics) do
				table.insert(msgs, d.message)
			end
			vim.fn.setreg("+", table.concat(msgs, "\n"))
			vim.notify("Copied " .. #msgs .. " diagnostic(s)", vim.log.levels.INFO)
		end, { buffer = buf, desc = "Copy Line Diagnostics" })
	end,
})
