-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

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

-- Map "Ctrl+p" to Telescope Find files
map("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end)

-- Map "Ctrl+n" to Telescope Recent files
map("n", "<c-n>", "<cmd>Telescope oldfiles<cr>")

wk.add({
  mode = { "n" },
  { "<leader>P", group = "Projects" },
  { "<leader>Pp", ":lua require'telescope'.extensions.project.project{}<CR>", desc = "Telescope project" },
  { "<leader>PP", ":ProjectMgr<CR>", desc = "ProjectMgr" },
})

-- ChatGPT mapping to open chat
map("n", "<leader>cc", ":ChatGPT<CR>", { desc = "ChatGPT" })

-- Find bugs with code using codeGPT
-- map(
--   "v",
--   "<leader>cp",
--   ":Chat refine this code by identifying and correcting any errors or bugs that may be present in the following snippet<CR>",
--   { desc = "ChatGPTProblem" }
-- )
wk.add({
  "<leader>cp",
  ":Chat fix<CR>",
  mode = "v",
  desc = "code",
})

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

-- Telescope browse
vim.api.nvim_set_keymap(
  "n",
  "<leader>fw",
  ":lua require('telescope').extensions.file_browser.file_browser({ path = vim.fn.expand('%:p:h'), select_buffer = true })<CR>",
  { noremap = true, silent = true, desc = "File browse" }
)

-- Navbuddy
map("n", "<leader>nv", ":Navbuddy<CR>", { desc = "Navbuddy" })

-- Telescope undo
map("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })

-- Trouble references
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble references" })

-- alias :TailwindSort neovim command to TW
vim.api.nvim_create_user_command("TW", ":TailwindSort", { nargs = 0 })

-- Create a keybinding for the function
map("n", "gw", "*N", { noremap = true, silent = true })

-- Lazygit change size of window
-- map("n", "<leader>gg", function()
--   Util.float_term({ "lazygit" }, { size = { width = 0.94, height = 0.94 }, cwd = Util.get_root() })
-- end, { desc = "Lazygit (root dir)" })

-- map("n", "<leader>gG", function()
--   Util.float_term({ "lazygit" }, { size = { width = 1.0, height = 1.0 } })
-- end, { desc = "Lazygit (cwd dir)" })

-- Harpoon
-- wk.register({
--   h = {
--     name = "harpoon",
--     x = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon Mark" },
--     n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Harpoon Nav Next" },
--     p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Harpoon Nav Prev" },
--     m = { ":Telescope harpoon marks<CR>", "Harpoon Marks" },
--   },
-- }, { prefix = "<leader>" })

-- Tabs
wk.add({
  group = "tabs",
  { "<leader><tab>h", "<cmd>tabprev<CR>", desc = "Previous tab" },
  { "<leader><tab>l", "<cmd>tabnext<CR>", desc = "Next tab" },
})

map("n", "<leader>gB", "<cmd>GBrowse<CR>", { desc = "Browse In Web" })

-- LazyVim switched off of TSTools in favor of nvim-lsp-ts-utils
-- -- add all missing imports using tsserver
-- map("n", "<leader>ci", ":TSToolsAddMissingImports<CR>", { desc = "Add Missing Imports" })
-- Rename filename of current buffer with TSC support
-- map("n", "<leader>cR", ":TSToolsRenameFile<CR>", { desc = "Rename file" })

-- -- add all missing imports using tsserver code action
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
