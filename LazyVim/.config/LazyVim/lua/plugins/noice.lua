return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      view = "mini",
      filter = {
        event = "notify",
        find = "No information available",
        any = {
          { find = "hidden" },
          { find = "clipboard" },
          { find = "Deleted" },
          { find = "Renamed" },
        },
      },
      opts = { skip = true },
    })
  end,
}
