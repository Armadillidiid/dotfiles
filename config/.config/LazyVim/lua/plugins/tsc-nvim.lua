local utils = {}

utils.find_tsc_bin = function()
  local node_modules_tsc_binary = vim.fn.findfile("node_modules/.bin/tsc", ".;")

  if node_modules_tsc_binary ~= "" then
    return node_modules_tsc_binary
  end

  return "tsc"
end

return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      bin_path = utils.find_tsc_bin(),
    })
  end
}
