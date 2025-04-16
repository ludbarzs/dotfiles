return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on these event (open file)
  build = ":TSUpdate", -- Exectues whe n plugin is updated or installed (Updates all language parsers)
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function() 
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({
      highlight = {
        enable = true,
      },
      -- enable indentaion
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true
      },
      -- ensure these language servers are installed 
      ensure_installed = {
        -- Core Languages
        "python",
        "php",
        "lua",
        "rust",

        -- Web Dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",         -- React/JSX/TSX

        -- Shell and Scripting
        "bash",

        -- Data Formats
        "json",
        "jsonc",
        "yaml",
        "toml",
        "xml",
        "csv",

        -- DB & Markup
        "sql",         -- MySQL, general SQL support
        "markdown",
        "markdown_inline",

        -- Config and Dev Tools
        "vim",
        "vimdoc",
        "query",       -- Treesitter's own query language
        "make",
        "dockerfile",
        "gitignore",
        "ini",

        -- Optional Nice-to-Haves
        "regex",       -- better regex highlighting
        "comment",     -- helps with comment-aware features
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
