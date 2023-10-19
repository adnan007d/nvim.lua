return {
  'prettier/vim-prettier',
  build = "yarn install --frozen-lockfile --production",
  ft = { 'javascript', 'typescript', 'css', 'markdown', 'html', 'javascriptreact', 'typescriptreact', 'json' }
}
