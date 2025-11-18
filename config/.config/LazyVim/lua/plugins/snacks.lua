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
      win = {
        input = {
          keys = {
            ["<a-a>"] = {
              "sidekick_send",
              mode = { "n", "i" },
            },
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
