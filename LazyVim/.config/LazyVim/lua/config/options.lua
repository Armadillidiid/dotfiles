-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set highlight groups for the Leap plugin
vim.cmd('highlight LeapLabelPrimary guifg=#fc0352 guibg=none')
vim.cmd('highlight LeapLabelSecondary guifg=cyan guibg=none')
vim.cmd('highlight LeapBackdrop guifg=grey')

-- Set the browser to open the leetcode problem in
vim.g.leetcode_browser = "firefox"
vim.g.leetcode_solution_filetype = "typescript"
vim.g.leetcode_hide_paid_only = 1
