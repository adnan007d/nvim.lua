vim.keymap.set("n", "<leader>pv",
  function()
    if pcall(require, "nvim-tree") then
      local buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      local cwd =  vim.fn.getcwd()

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
  end
)

-- From Theprimagen https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
-- Moves a line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])


vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- From Theprimagen End
--

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set("v", "<TAB>", ">gv")
vim.keymap.set("v", "<S-TAB>", "<gv")


vim.keymap.set("n", "[ct", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
