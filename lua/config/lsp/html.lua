return function()
  local lsp_util = require("config.lsp.util")
  local capabilities = lsp_util.capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local cmd_path = lsp_util.getHomeDirectory() ..
  "/vscode/extensions/html-language-features/server/out/node/htmlServerMain.js"
  require('lspconfig').html.setup({
    cmd = { "node", cmd_path, "--stdio" },
    on_attach = lsp_util.on_attach,
    filetypes = { "html", "templ" },
    capabilities = capabilities,
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingRangeProvider = false
    end
  })
end
