return {
  "ibhagwan/fzf-lua",
  
  opts = function(_, opts)
    local actions = require("fzf-lua").actions

    -- Merge opts with new settings
    opts.files = {
      cwd_prompt = false,
      actions = {
        ["alt-i"] = { actions.toggle_ignore },
        ["ctrl-h"] = { actions.toggle_hidden },
      },
    }

    opts.grep = {
      actions = {
        ["alt-i"] = { actions.toggle_ignore },
        ["ctrl-h"] = { actions.toggle_hidden },
      },
    }

    return opts
  end
}
