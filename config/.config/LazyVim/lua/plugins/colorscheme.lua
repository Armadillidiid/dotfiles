return {
  -- add gruvbox
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "neanias/everforest-nvim" },

  -- Configure LazyVim to load kanagawa
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
