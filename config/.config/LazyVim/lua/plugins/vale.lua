-- Vale grammar/spell checking is now handled by vale-ls (LSP) instead of nvim-lint
-- Configuration: vale-ls uses ~/.config/vale/.vale.ini automatically
-- To disable this and use nvim-lint instead, uncomment the code below

return {
  -- Uncomment this block if you prefer nvim-lint over vale-ls:
  --[[
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "vale" },
        text = { "vale" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      
      local vale = lint.linters.vale
      vale.args = vim.list_extend(vale.args or {}, {
        "--config=" .. vim.fn.expand("~/.config/vale/.vale.ini"),
      })
      
      local lint_augroup = vim.api.nvim_create_augroup("vale_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  --]]
}
