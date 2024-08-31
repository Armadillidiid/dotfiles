return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        kind = "info",
        any = {
          { find = "hidden" },
          { find = "clipboard" },
          { find = "Deleted" },
          { find = "Renamed" },
        },
      },
      opts = { skip = true },
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
