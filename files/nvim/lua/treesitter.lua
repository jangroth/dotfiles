return {
    {
        "nvim-treesitter/nvim-treesitter", -- smarter syntax highlighting/indent based on parse trees; also feeds Comment.nvim's commentstring detection
        branch = "main",
        lazy = false, -- plugin doesn't support lazy-loading
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({ "hcl", "markdown", "markdown_inline", "python", "terraform", "yaml" })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "hcl", "markdown", "python", "terraform", "yaml" },
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}
