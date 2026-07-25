return {
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- add/change/delete surrounding pairs (brackets, quotes, tags)
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
