return function()
  local lsp_util = require("config.lsp.util")
  local capabilities = lsp_util.capabilities

  require('lspconfig').tailwindcss.setup({
    on_attach = lsp_util.on_attach,
    capabilities = capabilities,
    filetypes = {
      "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir",
      "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex",
      "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css",
      "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript",
      "typescript", "typescriptreact", "vue", "svelte", 'templ'
    },
    init_options = {
      userLanguages = {
        templ = "html"
      }
    }
  })
end
