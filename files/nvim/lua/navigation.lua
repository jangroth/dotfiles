local map = vim.keymap.set

-- neo-tree: sidebar and floating file explorer
map("n", "<Leader>e", "<cmd>Neotree toggle position=left<CR>", { desc = "Toggle file explorer (sidebar)" })
map("n", "<Leader>E", "<cmd>Neotree toggle position=float<CR>", { desc = "Toggle file explorer (floating)" })
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
        "nvim-neo-tree/neo-tree.nvim", -- file explorer sidebar and floating panel
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            popup_border_style = "rounded",
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            document_symbols = {
                follow_cursor = true,
                window = {
                    mappings = {
                        ["<space>"] = { "toggle_node", nowait = true }, -- expand instantly, don't wait for a leader sequence
                    },
                },
            },
            source_selector = {
                winbar = true,
                sources = {
                    { source = "filesystem",       display_name = " Files" },
                    { source = "buffers",          display_name = " Buffers" },
                    { source = "git_status",       display_name = " Git" },
                    { source = "document_symbols", display_name = " Symbols" },
                },
            },
            window = {
                mappings = {
                    ["<Tab>"] = "next_source",
                    ["<S-Tab>"] = "prev_source",
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = { enabled = true },
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim", -- fuzzy finder for files, grep, buffers, git history
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/flash.nvim", -- enhanced f/F/t/T motions with labeled jump targets
        opts = {
            modes = {
                char = { enabled = true, jump_labels = true },
                search = { enabled = false },
            },
        },
    },
    { "christoomey/vim-tmux-navigator" }, -- seamless navigation between neovim splits and tmux panes
}
