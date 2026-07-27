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
    {
        "ThePrimeagen/harpoon", -- fast switching between a small working set of files (fewer than 5) for the current task
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("harpoon"):setup() end,
        keys = (function()
            local keys = {
                { "<Leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: add file" },
                { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon: toggle menu" },
            }
            for i = 1, 4 do
                table.insert(keys, { "<Leader>" .. i, function() require("harpoon"):list():select(i) end, desc = "Harpoon: go to " .. i })
            end
            return keys
        end)(),
    },
    {
        "folke/trouble.nvim", -- project-wide diagnostics/quickfix/loclist list (Problems panel equivalent)
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<Leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (workspace)" },
            { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (buffer)" },
        },
    },
    {
        "stevearc/aerial.nvim", -- headings/symbols outline sidebar; used for jumping around long markdown docs
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<Leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle outline (symbols/headings)" },
        },
    },
}
