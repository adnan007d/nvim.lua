return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    }

    require("treesitter-context").setup {
      enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false,  -- Enable multiwindow support.
      max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',      -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
    -- local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    -- treesitter_parser_config.templ = {
    --   install_info = {
    --     url = "https://github.com/vrischmann/tree-sitter-templ.git",
    --     files = { "src/parser.c", "src/scanner.c" },
    --     branch = "master",
    --   },
    -- }
    --
    -- vim.treesitter.language.register('templ', 'templ')
  end
}
