return {
    {
        "nvim-treesitter/nvim-treesitter", -- smarter syntax highlighting based on parse trees
        build = ":TSUpdate",
        opts = { highlight = { enable = true }, indent = { enable = true }, ensure_installed = { "python", "yaml" } },
    },
}
