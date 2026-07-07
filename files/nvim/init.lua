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

-- Plugins
require("lazy").setup({
    { "shaunsingh/nord.nvim" }, -- nord color scheme
    {
        "nvim-tree/nvim-tree.lua", -- file explorer sidebar
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim", -- configurable status line
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { options = { theme = "nord" } },
    },
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- add/change/delete surrounding pairs (brackets, quotes, tags)
    { "lewis6991/gitsigns.nvim", opts = {} }, -- git diff indicators in the sign column, hunk navigation and staging
    {
        "nvim-telescope/telescope.nvim", -- fuzzy finder for files, grep, buffers, git history
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter", -- smarter syntax highlighting based on parse trees
        build = ":TSUpdate",
        opts = { highlight = { enable = true }, indent = { enable = true }, ensure_installed = { "python", "yaml" } },
    },
    { "williamboman/mason.nvim", opts = {} }, -- installs and manages language servers
    {
        "williamboman/mason-lspconfig.nvim", -- bridges mason and nvim-lspconfig; auto-installs and configures LSPs
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ruff", "yamlls" },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                    ["yamlls"] = function()
                        require("lspconfig").yamlls.setup({
                            settings = {
                                yaml = {
                                    schemaStore = { enable = false, url = "" },
                                    schemas = require("schemastore").yaml.schemas(),
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp", -- autocompletion menu
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP completions
            "hrsh7th/cmp-buffer",   -- buffer word completions
            "hrsh7th/cmp-path",     -- file path completions
        },
    },
    { "b0o/SchemaStore.nvim" }, -- provides 500+ JSON/YAML schemas (Kubernetes, Helm, GitHub Actions, etc.)
    { "numToStr/Comment.nvim", opts = {} }, -- toggle comments with gcc (line) or gc (visual)
    { "folke/which-key.nvim", opts = {} },  -- shows available keymaps when pausing mid-sequence
    { "christoomey/vim-tmux-navigator" },   -- seamless navigation between neovim splits and tmux panes
})

vim.cmd.colorscheme("nord")

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
opt.scrolloff = 8
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
map("n", "<Leader>h", ":set hls!<CR>")
map("n", "<Leader>i", ":set ignorecase!<CR>")
map("n", "<Leader>p", ":set paste!<CR>")
map("n", "<Leader>c", ":set cursorline!<CR>")
map("n", "<Leader>e", ":NvimTreeToggle<CR>")
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>")
-- vim-tmux-navigator: navigate splits/panes from any mode
map({ "n", "i", "v" }, "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map({ "n", "i", "v" }, "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map({ "n", "i", "v" }, "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map({ "n", "i", "v" }, "<C-l>", "<cmd>TmuxNavigateRight<CR>")
