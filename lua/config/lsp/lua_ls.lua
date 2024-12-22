return function()
  local lsp_util = require("config.lsp.util")
  require("lspconfig").lua_ls.setup {
    on_attach = lsp_util.on_attach,
    capabibilities = lsp_util.capabilities,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  }
end
