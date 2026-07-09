local map = vim.keymap.set

map("n", "<Leader>e", ":NvimTreeToggle<CR>")
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<Leader>fF", function() require("telescope.builtin").find_files({ no_ignore = true }) end)
map("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>")
map("n", "<Leader>fG", function() require("telescope.builtin").live_grep({ additional_args = { "--no-ignore" } }) end)
map("n", "<Leader>fb", "<cmd>Telescope buffers<CR>")
-- vim-tmux-navigator: navigate splits/panes from any mode
map({ "n", "i", "v" }, "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map({ "n", "i", "v" }, "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map({ "n", "i", "v" }, "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map({ "n", "i", "v" }, "<C-l>", "<cmd>TmuxNavigateRight<CR>")

return {
    {
        "nvim-tree/nvim-tree.lua", -- file explorer sidebar
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { filters = { git_ignored = false }, update_focused_file = { enable = true } },
    },
    {
        "nvim-telescope/telescope.nvim", -- fuzzy finder for files, grep, buffers, git history
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    { "christoomey/vim-tmux-navigator" }, -- seamless navigation between neovim splits and tmux panes
}
