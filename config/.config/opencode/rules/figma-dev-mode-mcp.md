---
description: Figma MCP server rules
---

### Required flow (do not skip)

1. Run `get_figma_data` first to fetch the structured representation for the exact node(s).
2. Only after you have `get_figma_data`, download any assets needed using `download_figma_images` and start implementation.

### Asset rules

The Figma MCP Server provides an assets endpoint which can serve image and SVG assets

1. If the Figma MCP Server returns a localhost source for an image or an SVG, use that image or SVG source directly
2. DO NOT import/add new icon packages, all the assets should be in the Figma payload
3. do NOT use or create placeholders if a localhost source is provided
