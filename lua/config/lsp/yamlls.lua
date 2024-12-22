return function()
  local lsp_util = require("config.lsp.util")
  require('lspconfig').yamlls.setup {
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }
end
