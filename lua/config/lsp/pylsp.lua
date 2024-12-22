return function()
  local lsp_util = require("config.lsp.util")
  require('lspconfig').pylsp.setup({
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          autopep8 = { enabled = false },
          yapf = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  })
end
