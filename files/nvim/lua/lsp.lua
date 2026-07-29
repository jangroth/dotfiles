return {
	{ "williamboman/mason.nvim", opts = {} }, -- installs and manages language servers
	{
		"williamboman/mason-lspconfig.nvim", -- bridges mason and nvim-lspconfig; auto-installs and configures LSPs
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			-- Advertise nvim-cmp's completion capabilities to every server; per-server
			-- vim.lsp.config calls below merge on top of this base.
			vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

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
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- buffer word completions
			"hrsh7th/cmp-path", -- file path completions
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args) vim.snippet.expand(args.body) end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{ "b0o/SchemaStore.nvim" }, -- provides 500+ JSON/YAML schemas (Kubernetes, Helm, GitHub Actions, etc.)
}
