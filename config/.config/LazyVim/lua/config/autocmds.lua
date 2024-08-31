-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

-- Set highlight groups
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4befe" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff413f", bg = "#1e1e2f" })
  end,
})
