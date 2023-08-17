return {
  'Mofiqul/dracula.nvim',
  config = function(_)
    vim.cmd.colorscheme("dracula")
    if (jit.os ~= "Windows") then
      require("dracula").setup({ disable_background = true })
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  end
}
