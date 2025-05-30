return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function(_)
		vim.keymap.set(
			"n",
			"<leader>xq",
			"<cmd>TroubleToggle quickfix<cr>",
			{ silent = true, noremap = true, desc = "Toggle Trouble Quickfix" }
		)
	end,
}
