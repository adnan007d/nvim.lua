return function()
  local lsp_util = require("config.lsp.util")
  require('lspconfig').jsonls.setup({
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate= {enable = true},
      }
    }
  })
end
