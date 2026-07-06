-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key must be set before plugins load
vim.g.mapleader = "\\"

-- Plugins
require("lazy").setup({
    { "Mofiqul/dracula.nvim" },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { options = { theme = "dracula" } },
    },
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
})

vim.cmd.colorscheme("dracula")

-- Editor settings (mirrors vimrc)
local opt = vim.opt
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.number = true
opt.cursorline = true
opt.incsearch = true
opt.hlsearch = true
opt.laststatus = 2
opt.showcmd = true
opt.showmode = true
opt.ruler = true
opt.cmdheight = 1
opt.joinspaces = false
opt.backup = true
opt.backupdir = { vim.fn.expand("~/.local/share/nvim/backup//"), "." }
opt.undofile = true

-- Keymaps
local map = vim.keymap.set
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")
map("n", "<Leader>h", ":set hls!<CR>")
map("n", "<Leader>i", ":set ignorecase!<CR>")
map("n", "<Leader>l", ":set number!<CR>")
map("n", "<Leader>n", ":set number!<CR>")
map("n", "<Leader>p", ":set paste!<CR>")
map("n", "<Leader>c", ":set cursorline!<CR>")
map("n", "<C-n>", ":NvimTreeToggle<CR>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
