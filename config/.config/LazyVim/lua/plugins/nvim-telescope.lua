return {
  "nvim-telescope/telescope-project.nvim",
  dependencies = { "nvim-telescope/telescope-file-browser.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  },
}
