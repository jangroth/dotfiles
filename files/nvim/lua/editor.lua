return {
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- add/change/delete surrounding pairs (brackets, quotes, tags)
    {
        "Pocco81/auto-save.nvim", -- auto-saves on focus/buffer switch, removing the need for :w; save runs through :w so conform's format_on_save still applies
        event = "VeryLazy",
        opts = {
            trigger_events = { "FocusLost", "BufLeave" },
            condition = function(buf)
                -- exclude harpoon's quick-menu buffer: it has no file backing, and an
                -- auto-save mid-edit triggers harpoon's own write handler, closing the popup
                return vim.fn.getbufvar(buf, "&modifiable") == 1 and vim.bo[buf].filetype ~= "harpoon"
            end,
        },
    },
    {
        "ThePrimeagen/refactoring.nvim", -- extract function/variable, inline variable
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
        opts = {},
        keys = {
            { "<Leader>re", function() require("refactoring").refactor("Extract Function") end, mode = "v", desc = "Extract function" },
            { "<Leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = "v", desc = "Extract variable" },
            { "<Leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "v" }, desc = "Inline variable" },
        },
    },
    {
        "lewis6991/gitsigns.nvim", -- git diff indicators in the sign column, hunk navigation and staging
        opts = {
            current_line_blame = true,
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local map = vim.keymap.set
                map("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next git hunk" })
                map("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous git hunk" })
                map("n", "<Leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })
                map("n", "<Leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage git hunk" })
                map("n", "<Leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset git hunk" })
                map("n", "<Leader>gb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
            end,
        },
    },
    { "numToStr/Comment.nvim", opts = {} }, -- toggle comments with gcc (line) or gc (visual)
    {
        "OXY2DEV/markview.nvim", -- renders markdown (headings, tables, code blocks, etc.) in the buffer
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<Leader>mv", "<cmd>Markview<CR>", ft = "markdown", desc = "Toggle markdown preview" },
        },
    },
    {
        "folke/snacks.nvim", -- inline image preview (png, jpg, gif, etc.) via the Kitty graphics protocol
        opts = { image = {} },
    },
}
