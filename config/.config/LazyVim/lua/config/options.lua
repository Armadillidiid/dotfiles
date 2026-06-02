-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Set highlight groups for the Leap plugin
-- vim.cmd("highlight LeapLabelPrimary guifg=#fc0352 guibg=none")
-- vim.cmd("highlight LeapLabelSecondary guifg=cyan guibg=none")
-- vim.cmd("highlight LeapBackdrop guifg=grey")

-- Set the browser to open the leetcode problem in
vim.g.leetcode_browser = "firefox"
vim.g.leetcode_solution_filetype = "typescript"
vim.g.leetcode_hide_paid_only = 1

-- Enable LazyVim auto format
vim.g.autoformat = false

-- Set highlight for line column

vim.api.nvim_set_hl(0, "LineNr", { fg = "#cdd6f4" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#89b4fa" })
vim.cmd("highlight LineNr guifg=#b4befe")

-- Set this for ToggleTerm terminals to not be discarded when closed
opt.hidden = true

-- Line wrap
opt.wrap = true

vim.g.lazyvim_picker = "snacks"

-- if the completion engine supports the AI source, use that instead of inline suggestions
vim.g.ai_cmp = false

opt.laststatus = 4

vim.g.sidekick_nes = false

-- OSC52 clipboard via ojroques/nvim-osc52 inside Zellij
-- Zellij forwards OSC52 to Kitty but drops terminal reply
-- Paste reads from Neovim's own register to avoid terminal query hang
if vim.env.ZELLIJ then
  local function copy(lines, _)
    require("osc52").copy(table.concat(lines, "\n"))
  end
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "osc52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
