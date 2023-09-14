return function()
  require('lspconfig').tsserver.setup({
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingRangeProvider = false

      vim.api.nvim_create_autocmd("BufWritePre", {
        command = "Prettier",
      })
    end,
  })
end
