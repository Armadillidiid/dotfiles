return {
  "dpayne/CodeGPT.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.g["codegpt_commands"] = {
      ["fix"] = {
        user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nrefine this code by identifying and correcting any errors or bugs that may be present. {{language_instructions}}",
      },
    }
  end,
}
