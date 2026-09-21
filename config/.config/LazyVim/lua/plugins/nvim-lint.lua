return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = markdown == { "markdownlint" },
  },
  -- Disable MD013 (line length) and MD007 (unordered list indentation) for markdownlint
  config = function()
    local markdownlint = require("lint").linters.markdownlint
    markdownlint.args = {
      "--disable",
      "MD013",
      "MD007",
      "--", -- Required
    }
  end,
}
