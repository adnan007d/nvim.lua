return {
  'rcarriga/nvim-notify',
  config = function()
    vim.notify = require("notify")
    require("notify").setup({
      background_colour = require("dracula.palette").bg
    })
  end
}
