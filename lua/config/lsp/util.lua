local M = {}

M.on_attach = function(client, bufnr)
  require("config.inlayhints").setup(client, bufnr)

  local opts = { buffer = bufnr, remap = false }

  -- formatting
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

  local telescope = require("telescope.builtin")
  vim.keymap.set("n", 'gr', telescope.lsp_references, opts)
  vim.keymap.set("n", 'gI', telescope.lsp_implementations, opts)
  vim.keymap.set("n", '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", '<leader>ds', telescope.lsp_document_symbols, opts)
  vim.keymap.set("n", '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts)

  -- Lesser used LSP functionality
  vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local function getHomeDirectory()
    if jit.os ~= "Windows" then
        -- Windows
        return os.getenv('USERPROFILE') or os.getenv('HOME')
    else
        -- Unix-like systems
        return os.getenv('HOME')
    end
end

M.getHomeDirectory = getHomeDirectory


return M

