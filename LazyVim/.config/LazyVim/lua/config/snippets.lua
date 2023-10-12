local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node

ls.add_snippets("typescript", {
  typescript = {
    snip({
      trig = "rafcet",
      name = "react",
      dscr = "This is a react functional component with typescript",
      wordTrig = true,
    }, {
      text("import React from 'react';"),
      insert(1, "\n\n"),
      text("type ${1|ComponentName}Props = {};"),
      insert(1, "\n\n"),
      text("const ${1|ComponentName}: React.FC<${1|ComponentName}Props> = ({}: ${1|ComponentName}Props) => {"),
      insert(1, "\n"),
      text("  return ("),
      insert(1, "\n    "),
      text("<div>${2|ComponentName}</div>"),
      insert(1, "\n  );"),
      insert(1, "\n};"),
      insert(1, "\n\n"),
      text("export default ${1|ComponentName};")
    })
  }
})

