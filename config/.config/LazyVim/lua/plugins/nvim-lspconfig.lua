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
