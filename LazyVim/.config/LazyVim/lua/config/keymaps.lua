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

-- Map <leader><space> to search buffer
map("n", "<leader><space>", ":lua require('telescope.builtin').buffers()<CR>", { desc = "Search buffer" })

-- Telescope project_root
map(
  "n",
  "<leader>Pp",
  ":lua require'telescope'.extensions.project.project{}<CR>",
  { desc = "Telescope project", noremap = true, silent = true }
)

-- ProjectMgr
map("n", "<leader>PP", ":ProjectMgr<CR>", { desc = "ProjectMgr" })

-- ChatGPT mapping to open chat
map("n", "<leader>cc", ":ChatGPT<CR>", { desc = "ChatGPT" })

-- Find bugs with code using codeGPT
map(
  "x",
  "<leader>cp",
  ":Chat refine this code by identifying and correcting any errors or bugs that may be present in the following snippet<CR>",
  { desc = "ChatGPTProblem" }
)

-- Leetcode keymaps
map("n", "<leader>Ll", ":LeetCodeList<cr>", { desc = "LeetCodeList" })
map("n", "<leader>Lt", ":LeetCodeTest<cr>", { desc = "LeetCodeTest" })
map("n", "<leader>Ls", ":LeetCodeSubmit<cr>", { desc = "LeetCodeSubmit" })
map("n", "<leader>Li", ":LeetCodeSignIn<cr>", { desc = "LeetCodeSignIn" })

-- Telescope browse
vim.api.nvim_set_keymap(
  "n",
  "<leader>fw",
  ":lua require('telescope').extensions.file_browser.file_browser({ path = vim.fn.expand('%:p:h'), select_buffer = true })<CR>",
  { noremap = true, silent = true, desc = "File browse" }
)

-- Navbuddy
map("n", "<leader>nv", ":Navbuddy<CR>", { desc = "Navbuddy" })

-- Copilot
wk.register({
  ["<leader>cC"] = {
    name = "Copilot",
    d = { ":Copilot disable<CR>", "disable" },
    e = { ":Copilot enable<CR>", "enable" },
    s = { ":Copilot status<CR>", "status" },
  },
})

-- Ugaterm
wk.register({
  t = {
    name = "ugaterm",
    t = { ":UgatermOpen<CR>", "UgatermOpen" },
    d = { "<cmd>UgatermHide<CR>", "UgatermHide" },
  },
}, { prefix = "<leader>" })

-- Telescope undo
map("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })

-- Trouble references
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble references" })

-- alias :TailwindSort neovim command to TW
vim.api.nvim_create_user_command("TW", ":TailwindSort", { nargs = 0 })

-- Create a keybinding for the function
map('n', 'gw', '*N', { noremap = true, silent = true })

-- Lazygit change size of window
-- map("n", "<leader>gg", function()
--   Util.float_term({ "lazygit" }, { size = { width = 0.94, height = 0.94 }, cwd = Util.get_root() })
-- end, { desc = "Lazygit (root dir)" })

-- map("n", "<leader>gG", function()
--   Util.float_term({ "lazygit" }, { size = { width = 1.0, height = 1.0 } })
-- end, { desc = "Lazygit (cwd dir)" })

-- Rename filename of current buffer with TSC support
map("n", "<leader>cR", ":TSToolsRenameFile<CR>", { desc = "Rename file" })

-- Harpoon
wk.register({
  h = {
    name = "harpoon",
    x = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon Mark" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Harpoon Nav Next" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Harpoon Nav Prev" },
    m = { ":Telescope harpoon marks<CR>", "Harpoon Marks" },
  },
}, { prefix = "<leader>" })

