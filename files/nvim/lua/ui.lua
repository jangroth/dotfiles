-- must be set before the colorscheme is applied (see init.lua)
vim.g.nord_disable_background = true

return {
    { "shaunsingh/nord.nvim" }, -- nord color scheme
    {
        "nvim-lualine/lualine.nvim", -- configurable status line
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { options = { theme = "nord" } },
    },
    { "folke/which-key.nvim", opts = {} }, -- shows available keymaps when pausing mid-sequence
}
