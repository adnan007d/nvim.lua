return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "antosha417/nvim-lsp-file-operations",
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("lsp-file-operations").setup()
    require("nvim-tree").setup {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      }
    }
  end,
}
