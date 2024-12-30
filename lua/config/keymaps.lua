vim.keymap.set("n", "<leader>pv", function()
	if pcall(require, "nvim-tree") then
		local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
		local cwd = vim.fn.getcwd()

		-- if the current buffer is not a file, then use the cwd
		if buf_name ~= "" then
			cwd = vim.fn.fnamemodify(buf_name, ":p:h")
		end

		require("nvim-tree.api").tree.open({
			path = cwd,
		})
	else
		vim.cmd.Ex()
	end
end)

-- From Theprimagen https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- Moves a line up or down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Move Below Line to Current Line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to Next Match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to Previous Match" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace Text Without Overwriting the Unnamed Register" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+yy]], { desc = "Yank Current Line to System Clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete Without Trashing the Unnamed Register" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Move to Next Item in Quickfix List" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Move to Previous Item in Quickfix List" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Move to Next Item in Location List" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Move to Previous Item in Location List" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Substitute Word under Cursor" }
)
-- From Theprimagen End
--

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

vim.keymap.set("v", "<TAB>", ">gv", { desc = "Indent Line" })
vim.keymap.set("v", "<S-TAB>", "<gv", { desc = "Unindent Line" })

vim.keymap.set("n", "[t", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Jump to Current Context Top" })

vim.keymap.set("n", "<M-,>", "<c-w><", { desc = "Decrease Width of Window" })
vim.keymap.set("n", "<M-.>", "<c-w>>", { desc = "Increase Width of Window" })
vim.keymap.set("n", "<M-[>", ":resize -2<CR>", { desc = "Decrease Height of Window" })
vim.keymap.set("n", "<M-]>", ":resize +2<CR>", { desc = "Increase Height of Window" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Bottom Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Top Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })

vim.keymap.set("n", "<leader>wt", "<C-w>T", { desc = "Move Window to New Tab" })
