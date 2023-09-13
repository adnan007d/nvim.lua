local M = {
  _is_enabled = false,
  always_on = false, -- need to implement this
}

local setInlayHint = function(bufnr, enable)
  if vim.lsp.inlay_hint then
    M._is_enabled = enable;
    vim.lsp.inlay_hint(bufnr, enable);
  end
end


M.setup = function(client, bufnr)
  vim.api.nvim_set_hl(0, "LspInlayHint", { fg = require("dracula.palette").comment })

  if M._is_enabled then
    setInlayHint(bufnr, true)
  end
  vim.api.nvim_create_user_command("InlayHintEnable", function()
    setInlayHint(0, true)
  end, {});
  vim.api.nvim_create_user_command("InlayHintDisable", function()
    setInlayHint(0, false)
  end, {});

  -- vim.api.nvim_create_user_command("InlayHintToggleAlwaysOn", function()
  --   setInlayHint(0, true)
  -- end, {});
end

-- local inlayHintGroup = vim.api.nvim_create_augroup("InlayHintGroup", {
--   clear = false
-- })
--
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     if M.always_on == true then
--       setInlayHint(0, false)
--     end
--   end,
--   group = inlayHintGroup
-- })
--
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     if M.always_on == true then
--       vim.defer_fn(
--         function()
--           setInlayHint(0, true)
--         end, 300
--       )
--     end
--   end,
--   group = inlayHintGroup
-- })

return M;
