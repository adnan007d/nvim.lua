return function()
  local lsp_util = require("config.lsp.util")
  local capabilities = lsp_util.capabilities

  require('lspconfig').emmet_ls.setup({
    on_attach = lsp_util.on_attach,
    capabilities = capabilities,
    filetypes = { "templ", "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass",
      "scss", "svelte", "typescriptreact", "vue" },
  })
end
