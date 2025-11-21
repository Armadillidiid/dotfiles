return {
  "folke/snacks.nvim",
  -- stylua: ignore
  opts = {
    picker = {
      actions = {
        sidekick_send = function(...)
          return require("sidekick.cli.picker.snacks").send(...)
        end,
      },
      ---@field win? snacks.picker.win.Config
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
            ['<c-i>'] = { { 'toggle_ignored', 'toggle_hidden' }, mode = { 'i', 'n' } },
            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          },
        },
      },
    },
  },
  keys = {
    { "<c-p>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<c-n>", LazyVim.pick("oldfiles"), desc = "Recent" },
  },
}
