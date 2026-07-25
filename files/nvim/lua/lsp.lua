return {
	{ "williamboman/mason.nvim", opts = {} }, -- installs and manages language servers
	{
		"williamboman/mason-lspconfig.nvim", -- bridges mason and nvim-lspconfig; auto-installs and configures LSPs
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			-- Per-server overrides via the native vim.lsp.config API; mason-lspconfig's
			-- automatic_enable picks these up when it calls vim.lsp.enable() for installed servers.
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			vim.lsp.config("ruff", {
				init_options = {
					settings = {
						lint = { extendSelect = { "I" } }, -- also flag unsorted/unused imports (isort rules)
					},
				},
			})
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
			"hrsh7th/cmp-buffer", -- buffer word completions
			"hrsh7th/cmp-path", -- file path completions
		},
	},
	{ "b0o/SchemaStore.nvim" }, -- provides 500+ JSON/YAML schemas (Kubernetes, Helm, GitHub Actions, etc.)
}
