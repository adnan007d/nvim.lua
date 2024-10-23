return function()
  local lsp_util = require("config.lsp.util")
  require('lspconfig').ts_ls.setup({
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingRangeProvider = false

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   command = "Prettier",
      -- })
    end,
  })
end
