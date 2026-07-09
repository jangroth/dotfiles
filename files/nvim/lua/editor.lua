return {
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- add/change/delete surrounding pairs (brackets, quotes, tags)
    {
        "lewis6991/gitsigns.nvim", -- git diff indicators in the sign column, hunk navigation and staging
        opts = { current_line_blame = true },
    },
    { "numToStr/Comment.nvim", opts = {} }, -- toggle comments with gcc (line) or gc (visual)
}
