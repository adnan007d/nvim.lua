vim.api.nvim_set_hl(0, "NvimtreeNormal", { bg = "none" })

return {
	"Mofiqul/dracula.nvim",
	config = function(_)
		vim.cmd.colorscheme("dracula")
		require("dracula").setup({ disable_background = true })
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NvimtreeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
	end,
}
