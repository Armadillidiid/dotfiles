-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")
local luasnip = require("luasnip")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Leetcode keymaps
map("n", "<leader>Lm", ":Leet<cr>", { desc = "Menu" })
map("n", "<leader>Lt", ":Leet run<cr>", { desc = "Test" })
map("n", "<leader>Ls", ":Leet submit<cr>", { desc = "Submit" })
map("n", "<leader>Lr", ":Leet reset<cr>", { desc = "Reset question" })
map("n", "<leader>Ld", ":Leet desc<cr>", { desc = "Toggle description" })
map("n", "<leader>LR", ":Leet random<cr>", { desc = "Random question" })
map("n", "<leader>LD", ":Leet daily<cr>", { desc = "Daily question" })
map("n", "<leader>Li", ":Leet info<cr>", { desc = "Info" })
map("n", "<leader>Lp", ":Leet list<cr>", { desc = "Problem Picker" })
map("n", "<leader>Lu", ":Leet last_submit<cr>", { desc = "Previous submitted" })
map("n", "<leader>Lc", ":Leet console<cr>", { desc = "Console" })
map("n", "<leader>Lo", ":Leet open<cr>", { desc = "Open in Browser" })

-- Navbuddy
map("n", "<leader>nv", ":Navbuddy<CR>", { desc = "Navbuddy" })

-- Undo Changes Picker
map("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })

-- Trouble references
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble references" })

-- alias :TailwindSort neovim command to TW
vim.api.nvim_create_user_command("TW", ":TailwindSort", { nargs = 0 })

-- Create a keybinding for the function
map("n", "gw", "*N", { noremap = true, silent = true })

-- Tabs
wk.add({
  group = "tabs",
  { "<leader><tab>h", "<cmd>tabprev<CR>", desc = "Previous tab" },
  { "<leader><tab>l", "<cmd>tabnext<CR>", desc = "Next tab" },
})

-- Git Browse
map("n", "<leader>gB", "<cmd>GBrowse<CR>", { desc = "Browse In Web" })

-- add all missing imports using tsserver code action
map(
  "n",
  "<leader>ci",
  '<cmd>lua vim.lsp.buf.code_action({apply = true, context = {only = {"source.addMissingImports.ts"}, diagnostics = {}}})<CR>',
  { noremap = true, silent = true, desc = "Add Missing Imports" }
)

-- Move Lines
vim.keymap.del({ "n", "i", "v" }, "<A-j>")
vim.keymap.del({ "n", "i", "v" }, "<A-k>")
map("n", "<C-A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<C-A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<C-A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Luasnip
map({ "i", "s" }, "<c-j>", function()
  luasnip.jump(1)
end, { silent = true })
map({ "i", "s" }, "<c-k>", function()
  luasnip.jump(-1)
end, { silent = true })

-- Duplicate & comment line below/above
vim.keymap.set("n", "yp", "yypgcck^", { remap = true, silent = true, desc = "Duplicate & comment original below" })
vim.keymap.set("n", "yP", "yyPgccj^", { remap = true, silent = true, desc = "Duplicate & comment original above" })

-- Jump to start/end of line in insert mode
vim.keymap.set("i", "<C-a>", "<C-o>^", { desc = "Start of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })

-- Unbind <C-k> in insert mode to avoid conflicts
vim.keymap.del("i", "<C-k>")
-- Delete upto cursor in insert mode
vim.keymap.set("i", "<C-k>", "<C-o>d$", { desc = "Delete to end of line" }) -- conflicts LSP signature help

-- Replace word under cursor globally
vim.keymap.set(
  "n",
  "<leader>sx",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word globally" }
)

-- Unbind default tab keymaps
-- vim.keymap.del("n", "<leader><tab>f") -- Go to first tab

-- Duplicate current buffer in new tab
vim.keymap.set("n", "<leader><tab>b", "<cmd>tab split<CR>", { desc = "Duplicate buffer" })

-- Go to Definition in new tab
vim.keymap.set("n", "gt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition in new Tab" })
vim.keymap.set("n", "gb", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition in new Split" })

-- Recenter screen on j/k movements
vim.keymap.set("n", "<C-S-j>", "jzz", { desc = "Move down and recenter" })
vim.keymap.set("n", "<C-S-k>", "kzz", { desc = "Move up and recenter" })

-- Allow saving of files as sudo
vim.cmd([[
  cnoreabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]])

-- Disable AI code suggestions
vim.keymap.set("n", "<leader>ai", function()
  vim.cmd("Copilot disable")
  vim.cmd("Sidekick nes disable")
  print("AI Suggestions Disabled")
end, { desc = "Toggle AI Code Suggestions" })
