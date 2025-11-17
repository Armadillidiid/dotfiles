return {
  enabled = false,
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    -- Migrated to new provider configuration format
    provider = "openai",
    cursor_applying_provider = "groq", -- Use Groq for applying
    
    -- New providers table (migrated from top-level openai and vendors.groq)
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o-mini",
        timeout = 30000,
        max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      groq = {
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "llama-3.3-70b-versatile",
        max_tokens = 65536, -- migrated from max_completion_tokens
      },
    },
    
    behaviour = {
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    rag_service = {
      enabled = false, -- Enables the RAG service
      host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
      llm_model = "", -- The LLM model to use for RAG service
      embed_model = "", -- The embedding model to use for RAG service
      endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
    },
    mappings = {
      ask = "<leader>aA",
    },
  },
}
