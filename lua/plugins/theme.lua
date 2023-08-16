return {
  'Mofiqul/dracula.nvim',
  config = function(_)
    require("dracula").setup({ disable_background = true })

    vim.cmd.colorscheme("dracula")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end
}
