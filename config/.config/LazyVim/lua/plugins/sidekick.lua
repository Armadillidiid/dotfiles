return {
  "folke/sidekick.nvim",
  optional = true,
  opts = {
    cli = {
      ---@class sidekick.cli.Mux
      ---@field backend? "tmux"|"zellij" Multiplexer backend to persist CLI sessions
      mux = {
        enabled = true,
        backend = "zellij",
      },
      ---@class sidekick.win.Opts
      win = {
        ---@type table<string, sidekick.cli.Keymap|false>
        keys = {
          prompt = { "<c-s-p>", "prompt", mode = "t", desc = "insert prompt or context" },
        },
      },
    },
  },
  keys = {
    { "<leader>aa", false },
    { "<leader>aP", false },
    {
      "<leader>aP",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  },
}
