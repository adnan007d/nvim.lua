return {
	"stevearc/conform.nvim",
	config = function()
		local prettier_fts = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"markdown",
			"vue",
			"css",
			"json",
			"html",
		}

		local formatters_by_ft = {
			lua = { "stylua" },
		}

		for _, ft in ipairs(prettier_fts) do
			formatters_by_ft[ft] = { "prettier", "prettier", stop_after_first = true }
		end

		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			default_format_opts = {
				lsp_format = "fallback",
			},
		})
	end,
}
