return {
    { "williamboman/mason.nvim", opts = {} }, -- installs and manages language servers
    {
        "williamboman/mason-lspconfig.nvim", -- bridges mason and nvim-lspconfig; auto-installs and configures LSPs
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "ruff", "yamlls", "marksman" },
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
}
