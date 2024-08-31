vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" })
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    panel = { enabled = true },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-Space>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = true,
      markdown = true,
      help = true,
    },
  },
}
