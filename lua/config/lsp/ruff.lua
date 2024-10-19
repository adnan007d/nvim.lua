return function()
  local lsp_util = require("config.lsp.util")
  require('lspconfig').ruff.setup({
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    init_options = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
  })
end
