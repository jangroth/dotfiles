return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim", -- ensures non-LSP tools (formatters, linters) are installed via mason
        dependencies = { "williamboman/mason.nvim" },
        opts = { ensure_installed = { "yamlfmt" } },
    },
    {
        "stevearc/conform.nvim", -- formats buffers on save using per-filetype formatters
        opts = {
            formatters_by_ft = { yaml = { "yamlfmt" } },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
    },
}
