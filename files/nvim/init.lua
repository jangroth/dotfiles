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
for _, mod in ipairs({ "ui", "navigation", "editor", "treesitter", "lsp", "format" }) do
    vim.list_extend(plugins, require(mod))
end
require("lazy").setup(plugins)

vim.cmd.colorscheme("nord")

-- neo-tree's expand/collapse arrow defaults to dim gray, hard to see against nord's background
vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#88C0D0", bold = true })

-- Core editor settings and keymaps
require("options")
