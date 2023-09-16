return function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  require('lspconfig').tsserver.setup({
    capabilities = capabilities,
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingRangeProvider = false

      vim.api.nvim_create_autocmd("BufWritePre", {
        command = "Prettier",
      })
    end,
  })
end
