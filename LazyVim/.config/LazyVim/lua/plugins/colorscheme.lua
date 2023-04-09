return {
  -- add gruvbox
  { "rebelot/kanagawa.nvim" },
  { "catppuccin/nvim" },
  -- Configure LazyVim to load kanagawa
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
