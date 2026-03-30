local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- ui
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.cursorline = true
opt.laststatus = 3
opt.cmdheight = 0

-- file
opt.autoread = true
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- diagnostics
vim.diagnostic.config({
    severity_sort = true,
    virtual_text = false,
    signs = true,
    float = { border = "rounded", source = "if_many" },
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
            border = "rounded",
            scope = "cursor",
        })
    end,
})

-- auto-reload files changed outside nvim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    command = "checktime",
})

-- misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 100
opt.splitright = true
opt.splitbelow = true
