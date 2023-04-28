-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
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

-- Map "jk" to exit Insert mode
map("i", "jk", "<Esc>", { noremap = true })

-- Map "Ctrl+p" to Telescope Find files
map("n", "<C-p>", Util.telescope("files"))

-- Map "Ctrl+n" to Telescope Recent files
map("n", "<c-n>", "<cmd>Telescope oldfiles<cr>")

-- -- Toggle auto-save
-- map("n", "<leader>n", ":ASToggle<CR>", { desc = "Toggle auto-save" })

--n  Map <leader><space> to delete buffer
-- map("n", "<leader><space>", ':lua require("mini.bufremove").delete(0, false)<CR>', { desc = "Delete buffer" })

-- Telescope project_root
map(
  "n",
  "<leader>pP",
  ":lua require'telescope'.extensions.project.project{}<CR>",
  { desc = "Telescope project", noremap = true, silent = true }
)

-- ProjectMgr
map("n", "<leader>pp", ":ProjectMgr<CR>", { desc = "ProjectMgr" })

-- ChatGPT mapping to open chat
map("n", "<leader>cc", ":ChatGPT<CR>", { desc = "ChatGPT" })

-- Find bugs with code using codeGPT
map("v", "<leader>cp", ":Chat please fix any bugs and errors in the following code<CR>", { desc = "ChatGPTProblem" })
map("x", "<leader>cp", ":Chat please fix any bugs and errors in the following code<CR>", { desc = "ChatGPTProblem" })

-- Leetcode keymaps
map("n", "<leader>Ll", ":LeetCodeList<cr>", { desc = "LeetCodeList" })
map("n", "<leader>Lt", ":LeetCodeTest<cr>", { desc = "LeetCodeTest" })
map("n", "<leader>Ls", ":LeetCodeSubmit<cr>", { desc = "LeetCodeSubmit" })
map("n", "<leader>Li", ":LeetCodeSignIn<cr>", { desc = "LeetCodeSignIn" })

-- Telescope browse
map("n", "<leader>fB", ":lua require 'telescope'.extensions.file_browser.file_browser()<CR>", { desc = "File browse" })

-- Navbuddy
map("n", "<leader>nv", ":Navbuddy<CR>", { desc = "Navbuddy" })

-- Copilot
wk.register({
  ["<leader>cC"] = {
    name = "Copilot",
    d = {":Copilot disable<CR>", "disable"},
    e = {":Copilot enable<CR>", "enable"},
    s = {":Copilot status<CR>", "status"}
  }
})

-- Ugaterm
wk.register({
  t = {
    name = "ugaterm",
    t = {':UgatermToggle<CR>', 'UgatermToggle'},
    n = {'<cmd>UgatermNew<CR>', 'UgatermNew'},
    d = {'<cmd>UgatermDelete<CR>', 'UgatermDelete'},
    s = {'<cmd>UgatermSelect<CR>', 'UgatermSelect'},
  }
}, { prefix = "<leader>"})


-- Telescope undo
map("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })
