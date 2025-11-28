return {
  "folke/snacks.nvim",
  -- stylua: ignore
  opts = {
    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
        yank_relative_cwd = function(_, item)
          local path = vim.fn.fnamemodify(item.file, ":.")
          vim.fn.setreg("+", path)
          vim.fn.setreg('"', path)
        end,
      },
      ---@class snacks.picker.win.Config
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
            ['<c-i>'] = { { 'toggle_ignored', 'toggle_hidden' }, mode = { 'i', 'n' } },
            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<c-y>"] = { "yank_relative_cwd", mode = {"i", "n"} },
          },
        },
      },
      ---@class snacks.picker.formatters.Config
      formatters = {
        file = {
          min_width = 80,
        }
      }
    },
  },
  keys = {
    { "<c-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<c-n>", LazyVim.pick("oldfiles"), desc = "Recent" },
  },
}
