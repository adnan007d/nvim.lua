return {
  -- LSP Support
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim',          config = true },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- lsp for neovim setting
    { "folke/neodev.nvim",                opts = {} },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    -- status updates for lsp
    {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      opts = {},
      config = function()
        require('fidget').setup({
        })
        local dracula = require("dracula.palette")
        vim.cmd("highlight FidgetTask ctermfg=0 guifg=" .. dracula.purple)
        vim.cmd("highlight FidgetTitle ctermfg=0 guifg=" .. dracula.fg)

      end
    },
  },
  config = function()
    require("config.lsp")
    -- autoformat from kickstart.nvim
    require("config.autoformat")
  end
}
