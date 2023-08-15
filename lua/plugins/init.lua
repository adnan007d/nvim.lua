return {
  {'Mofiqul/dracula.nvim',
  config = function(LazyPlugin)
    vim.cmd("colorscheme dracula")
  end},
  {"nvim-treesitter/nvim-treesitter", build = function() 
    require("nvim-treesitter.install").update({ with_sync = true })
  end },
   {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  "theprimeagen/harpoon",
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "nvim-treesitter/nvim-treesitter-context",
}

