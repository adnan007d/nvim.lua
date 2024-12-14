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
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
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
        -- "ts_ls",
        "eslint",
        "emmet_ls",
        "tailwindcss",
        "svelte",
        "jsonls",
        "yamlls"
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
        ts_ls = require("config.lsp.ts_ls"),
        tailwindcss = require("config.lsp.tailwindcss"),
        emmet_ls = require("config.lsp.emmet_ls"),
        jsonls = require("config.lsp.jsonls"),
        yamlls = require("config.lsp.yamlls"),
        ruff = require("config.lsp.ruff"),
        pylsp = require("config.lsp.pylsp"),
      }

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
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
          ["<C-q>"] = cmp.mapping.complete(),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
          -- ['<CR>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     if luasnip.expandable() then
          --       luasnip.expand()
          --     else
          --       cmp.confirm({
          --         select = true,
          --       })
          --     end
          --   else
          --     fallback()
          --   end
          -- end),

          -- ["<Tab>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif luasnip.locally_jumpable(1) then
          --     luasnip.jump(1)
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

        }),
        sources = {
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


      -- vim.lsp.buf.hover({
      --   border = "rounded"
      -- })
      --
      -- vim.lsp.buf.signature_help({
      --   border = "rounded"
      -- })

      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "rounded" }
      })

      -- vim.filetype.add({
      --   extension = {
      --     templ = "templ",
      --   },
      -- })
    end
  }
}
