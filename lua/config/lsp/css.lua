return function()
  local lsp_util = require("config.lsp.util")
  local capabilities = lsp_util.capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local cmd_path = lsp_util.getHomeDirectory() .. "/vscode/extensions/css-language-features/server/out/node/cssServerMain.js"
  require('lspconfig').cssls.setup({
    cmd = { "node", cmd_path, "--stdio" },
    on_attach = lsp_util.on_attach,
    capabilities = capabilities,
  })
end
