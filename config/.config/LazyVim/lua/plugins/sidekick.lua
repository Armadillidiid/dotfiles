return {
  "folke/sidekick.nvim",
  optional = true,
  opts = {
    cli = {
      tools = {
        amazon_q = { cmd = { "kiro-cli", "--v3" } },
        -- tool keys override cli.win.keys, so force <c-s-p> here too.
        -- Keep this a pure array: sidekick copies the tool table into `vim.b`,
        -- and mixed array/dict tables can't convert to Vimscript (E5100).
        opencode = {
          keys = {
            prompt = { "<c-s-p>", "prompt" },
          },
        },
      },
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
          -- unbind keys that shadow opencode's TUI keybinds
          buffers = false, -- <c-b>: input move-left / diff page up / session background
          files = false, -- <c-f>: input move-right / diff page / session pin
          -- hide_ctrl_dot = false, -- <c-.>: input redo
          hide_ctrl_z = false, -- <c-z>: terminal suspend
          nav_left = false, -- <c-h/j/k/l>: input newline / delete-to-eol / clear
          nav_down = false,
          nav_up = false,
          nav_right = false,
          prompt = { "<c-s-p>", "prompt", mode = "t", desc = "insert prompt or context" },
        },
      },
    },
  },
  keys = {
    { "<leader>aa", false },
    { "<leader>ap", false },
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
