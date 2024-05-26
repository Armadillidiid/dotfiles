return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      view = "mini",
      filter = {
        event = "notify",
        any = {
          { find = "hidden" },
          { find = "clipboard" },
          { find = "Deleted" },
          { find = "Renamed" },
        },
      },
    })
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    })
  end,
}
