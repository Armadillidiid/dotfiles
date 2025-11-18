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
}
