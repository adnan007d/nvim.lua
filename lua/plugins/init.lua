return {
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",
  -- "vrischmann/tree-sitter-templ",
  "b0o/schemastore.nvim",
  "michaeljsmith/vim-indent-object",
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  -- },
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup({
        bin_path = vim.fn.findfile("node_modules/.bin/tsc"),
      })
    end
  },
  "sindrets/diffview.nvim",
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = { theme = "dracula" }
  }
}
