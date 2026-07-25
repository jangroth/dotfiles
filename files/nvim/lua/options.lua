-- Editor settings (mirrors vimrc)
local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.joinspaces = false
opt.laststatus = 3
opt.number = true
opt.relativenumber = true
opt.scrolloff = 16
opt.shiftwidth = 2
opt.signcolumn = "yes"
opt.smartcase = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.wrap = false

-- Keymaps
local map = vim.keymap.set
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "<Leader>h", ":set hls!<CR>")
map("n", "<Leader>i", ":set ignorecase!<CR>")
map("n", "<Leader>w", ":set wrap!<CR>")
