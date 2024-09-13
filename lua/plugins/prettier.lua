return {
  'prettier/vim-prettier',
  build = "npm install --frozen-lockfile --production",
  ft = { 'javascript', 'typescript', 'css', 'markdown', 'html', 'javascriptreact', 'typescriptreact', 'json' }
}
