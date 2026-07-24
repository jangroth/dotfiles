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
vim.g.mapleader = " "

-- Plugins (collected from lua/*.lua modules)
local plugins = {}
for _, mod in ipairs({ "ui", "navigation", "editor", "treesitter", "lsp", "format", "debugging" }) do
    vim.list_extend(plugins, require(mod))
end
require("lazy").setup(plugins)

vim.cmd.colorscheme("nord")

-- Core editor settings and keymaps
require("options")
