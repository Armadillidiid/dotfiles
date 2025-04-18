vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83a598" })
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  enabled = true,
  lazy = false,
  build = ":Copilot auth",
  opts = function()
    require("copilot.api").status = require("copilot.status")

    return {
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
    }
  end,
}
