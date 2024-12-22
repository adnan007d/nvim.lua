return {
  'prettier/vim-prettier',
  enabled = false,
  build = "npm install --frozen-lockfile --production",
  ft = { 'javascript', 'typescript', 'css', 'markdown', 'html', 'javascriptreact', 'typescriptreact', 'json' }
}
