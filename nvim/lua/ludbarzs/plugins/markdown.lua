return {

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }, -- Lazy-load only for these commands
    ft = { "markdown" }, -- Load only when editing markdown files
    build = "cd app && npm install", -- Hook to run after installing plugin
    config = function() -- Config runs when the plugin is loaded
      vim.g.mkdp_auto_start = 0 -- Don't auto-start preview
      vim.g.mkdp_auto_close = 1 -- Auto-close preview when buffer is closed
      vim.g.mkdp_refresh_slow = 0 -- Don't throttle refresh
      vim.g.mkdp_preview_options = { -- Extra preview behavior
        disable_sync_scroll = 0, -- Sync scrolling with source
        disable_filename = 0, -- Show filename in preview
      }

      -- Create keybindings when filetype is markdown
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local opts = { buffer = true }

          -- Toggle Markdown Preview
          vim.keymap.set(
            "n",
            "<leader>mp",
            "<cmd>MarkdownPreviewToggle<CR>",
            { desc = "Toggle Markdown Preview", buffer = true }
          )

          -- Export Mermaid diagram via mermaid-cli
          vim.keymap.set(
            "n",
            "<leader>me",
            ":w<CR>:!npx @mermaid-js/mermaid-cli -i %<CR>",
            { desc = "Export Mermaid as SVG", buffer = true }
          )
        end,
      })
    end,
  },

  {
    "preservim/vim-markdown",
    ft = { "markdown" }, -- Load only for markdown
    dependencies = { "godlygeek/tabular" }, -- Required dep for table alignment
    config = function()
      vim.g.vim_markdown_math = 1 -- Enable LaTeX math support
      vim.g.vim_markdown_frontmatter = 1 -- Support YAML frontmatter
      vim.g.vim_markdown_strikethrough = 1 -- Enable ~~strikethrough~~
      vim.g.vim_markdown_folding_disabled = 1 -- Disable folding
      vim.g.vim_markdown_conceal = 2 -- Use medium conceal level (symbols get prettier)
      vim.g.vim_markdown_conceal_code_blocks = 0 -- Don’t conceal code block fences
      vim.g.vim_markdown_follow_anchor = 1 -- Follow links with `gf`

      -- Adjust conceal level when editing markdown
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2 -- Set conceal level (inline hiding)
        end,
      })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" }, -- Only for markdown
    config = function()
      vim.g.table_mode_corner = "|" -- Use pipe character as table corner

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>tm", "<cmd>TableModeToggle<CR>", { desc = "Toggle Table Mode", buffer = true })
          vim.keymap.set("n", "<leader>tf", "<cmd>TableModeRealign<CR>", { desc = "Format Table", buffer = true })
        end,
      })
    end,
  },
  {
    "jbyuki/nabla.nvim",
    ft = { "markdown" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Open LaTeX preview popup
          vim.keymap.set("n", "<leader>ml", function()
            require("nabla").popup()
          end, { desc = "Preview LaTeX formula", buffer = true })

          -- Toggle virtual inline rendering
          vim.keymap.set("n", "<leader>ms", function()
            require("nabla").toggle_virt()
          end, { desc = "Toggle inline LaTeX preview", buffer = true })
        end,
      })
    end,
  },
}
