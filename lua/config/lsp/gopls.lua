return function()
  require("lspconfig").gopls.setup {
    settings = {
      gopls = {
        -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        -- not supported
        analyses = {
          unreachable = true,
          nilness = true,
          unusedparams = true,
          useany = true,
          unusedwrite = true,
          undeclaredname = true,
          fillreturns = true,
          nonewvars = true,
          fieldalignment = false,
          shadow = true,
        },
        codelenses = {
          -- generate = true,   -- show the `go generate` lens.
          gc_details = true, -- Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
          vendor = true,
          regenerate_cgo = true,
          upgrade_dependency = true,
          run_govulncheck = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'Fuzzy',
        -- diagnosticsDelay = '500ms',
        symbolMatcher = 'fuzzy',
        buildFlags = { '-tags', 'integration' },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    }
  }
end
