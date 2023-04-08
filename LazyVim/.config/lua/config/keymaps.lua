-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

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

-- Toggle auto-save
map("n", "<leader>n", ":ASToggle<CR>", { desc = "Toggle auto-save" })

--n  Map <leader><space> to delete buffer
map("n", "<leader><space>", ':lua require("mini.bufremove").delete(0, false)<CR>', { desc = "Delete buffer" })

-- Telescope project_root
map("n", "<leader>pP", ":lua require'telescope'.extensions.project.project{}<CR>", { desc = "Telescope project",  noremap = true, silent = true })

-- ProjectMgr
map("n", "<leader>pp", ":ProjectMgr<CR>", { desc = "ProjectMgr" })

-- ChatGPT mapping to open chat 
map("n", "<leader>cc", ":ChatGPT<CR>", { desc = "ChatGPT" })

-- Find bugs with code using codeGPT
map("v", "<leader>cp", ":Chat please fix any bugs and errors in the following code<CR>", { desc = "ChatGPTProblem" })
map("x", "<leader>cp", ":Chat please fix any bugs and errors in the following code<CR>", { desc = "ChatGPTProblem" })

-- nvim-surround
-- vim.g["surround_no_mappings"] = 1
-- vim.keymap.set("n", "ds", "<Plug>Dsurround")
-- map("n", "cs", "<Plug>Csurround")
-- map("n", "cS", "<Plug>CSurround")
-- map("n", "ys", "<Plug>Ysurround")
-- map("n", "yS", "<Plug>YSurround")
-- map("n", "yss", "<Plug>Yssurround")
-- map("n", "ySs", "<Plug>YSsurround")
-- map("n", "ySS", "<Plug>YSsurround")
--
-- -- The conflicting ones. Note that `<Plug>(leap-cross-window)`
-- -- _does_ work in Visual mode, if jumping to the same buffer,
-- -- so in theory, `gs` could be useful for Leap too...
-- map("x", "gs", "<Plug>VSurround")
-- map("x", "gS", "<Plug>VgSurround")
