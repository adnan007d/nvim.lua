vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- From Theprimagen https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua 

-- Moves a line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
