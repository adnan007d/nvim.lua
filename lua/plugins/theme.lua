return {
	"Mofiqul/dracula.nvim",
	config = function(_)
		vim.cmd.colorscheme("dracula")
		require("dracula").setup()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimtreeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

		vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = "none" }) -- Completion item text
	end,
}
