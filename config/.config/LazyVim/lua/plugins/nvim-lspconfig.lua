-- Whitelist of directories where tsgo should be enabled
local tsgo_whitelist = {
  "/home/emmanuel/ghq/github.com/Armadillidiid/cal.com",
}

-- Check if current directory is in the whitelist
local function should_use_tsgo()
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(tsgo_whitelist) do
    if cwd == path then
      return true
    end
  end
  return false
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
  opts = {
    servers = {
      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              },
            },
          },
        },
      },
      vtsls = {
        settings = {
          vtsls = {
            experimental = {
              completion = {
                entriesLimit = 50,
              },
            },
          },
          typescript = {
            experimental = {
              useTsgo = should_use_tsgo(),
            },
            preferences = {
              includePackageJsonAutoImports = "off",
              -- autoImportFileExcludePatterns = true,
            },
            tsserver = {
              maxTsServerMemory = 8192,
            },
          },
        },
      },
    },
  },
}
