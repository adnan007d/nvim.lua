return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  { "folke/neodev.nvim", opts = {}, config = function() require("neodev").setup({}) end },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },


      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },


      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp_zero = require('lsp-zero').preset("recommended")

      require('luasnip.loaders.from_vscode').lazy_load()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_format = lsp_zero.cmp_format()
      local luasnip = require 'luasnip'

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        formatting = cmp_format,
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })

      lsp_zero.on_attach(function(client, bufnr)
        require("config.inlayhints").setup(client, bufnr)


        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        local telescope = require("telescope.builtin")
        vim.keymap.set("n", 'gr', telescope.lsp_references, opts)
        vim.keymap.set("n", 'gI', telescope.lsp_implementations, opts)
        vim.keymap.set("n", '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", '<leader>ds', telescope.lsp_document_symbols, opts)
        vim.keymap.set("n", '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts)

        -- Lesser used LSP functionality
        vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
      end)

      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
          ['gopls'] = { 'go' }
        }
      })


      require("mason").setup();
      require("mason-lspconfig").setup({
        ensure_installed = { "tsserver", "gopls", "rust_analyzer", "eslint", "emmet_ls", "html", "tailwindcss", "svelte" },
        handlers = {
          lsp_zero.default_setup,
          gopls = require("config.lsp.gopls"),
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            lua_opts.settings.Lua.hint = { enable = true }
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text = true
      })
    end
  }
}
