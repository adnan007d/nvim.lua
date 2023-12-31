return {
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          config = true, },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },


      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      },
      { 'rafamadriz/friendly-snippets' },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      require("neodev").setup()

      require("mason").setup();
      local mason_lspconfig = require("mason-lspconfig")

      local servers = {
        "lua_ls",
        "tsserver",
        "gopls",
        "rust_analyzer",
        "eslint",
        "emmet_ls",
        "tailwindcss",
        "svelte",
        "templ",
      }
      local lsp_util = require("config.lsp.util")
      mason_lspconfig.setup({
        ensure_installed = servers,
      })
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = lsp_util.capabilities,
            on_attach = lsp_util.on_attach,
          }
        end,
        lua_ls = require("config.lsp.lua_ls"),
        gopls = require("config.lsp.gopls"),
        tsserver = require("config.lsp.tsserver"),
        tailwindcss = require("config.lsp.tailwindcss"),
        emmet_ls = require("config.lsp.emmet_ls")
      }

      require("config.lsp.html")();
      -- require("config.lsp.css")();

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      local has_words_before = function()
        if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      cmp.setup({
        window = {
          documentation = { -- no border; native-style scrollbar
            border = "rounded",
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = "copilot" },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'nvim_lua' }
        },
      })


      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded" }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
      )

      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "rounded" }
      })

      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })
    end
  }
}
