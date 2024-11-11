return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  opts = {
    search = {
      pattern = [[\b(KEYWORDS)( \[\d{4}-\d{2}-\d{2}\])?:]], -- ripgrep regex
    },
  },
}
