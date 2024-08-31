return {
  "jvgrootveld/telescope-zoxide",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    -- Useful for easily creating commands
    local z_utils = require("telescope._extensions.zoxide.utils")
    local t = require("telescope")

    t.setup({
      -- (other Telescope configuration...)
      extensions = {
        zoxide = {
          prompt_title = "[ Zoxide List ]",

          -- Zoxide list command with score
          list_command = "zoxide query -ls",
          mappings = {
            default = {
              action = function(selection)
                vim.cmd.edit(selection.path)
              end,
              after_action = function(selection)
                print("Directory changed to " .. selection.path)
              end
            },
            ["<C-s>"] = { action = z_utils.create_basic_command("split"), desc = "Open selection in a split" },
            ["<C-v>"] = { action = z_utils.create_basic_command("vsplit"), desc = "Open selection in a vertical split" },
            ["<C-e>"] = { action = z_utils.create_basic_command("edit"), desc = "Open selection in current window" },
            ["<C-b>"] = {
              action = function(selection)
                vim.cmd("Telescope file_browser path=" .. selection.path .. " select_buffer=true")
              end,
              after_action = function(selection)
                vim.notify("Directory changed to " .. selection.path)
              end,
              desc = "Open selection in Telescope's file browser"
            },
            ["<C-f>"] = {
              keepinsert = true,
              action = function(selection)
                require("telescope.builtin").find_files({ cwd = selection.path })
              end,
              desc = "Open selection in Telescope's find files"
            },
            ["<C-t>"] = {
              action = function(selection)
                vim.cmd.tcd(selection.path)
              end,
              desc = "Change current tab's directory to selection"
            },
          }
        }
      }
    })

    -- Load the extension
    t.load_extension('zoxide')

    -- Add a mapping
    vim.keymap.set("n", "<leader>fx", t.extensions.zoxide.list, { desc = "Zoxide list" })
  end,
}

