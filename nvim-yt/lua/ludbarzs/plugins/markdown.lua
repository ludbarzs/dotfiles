return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = "librewolf"
      vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 0,
      }

      -- Set keymaps for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set(
            "n",
            "<leader>mp",
            "<cmd>MarkdownPreviewToggle<CR>",
            { desc = "Toggle Markdown Preview", buffer = true }
          )
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
    ft = { "markdown" },
    dependencies = { "godlygeek/tabular" },
    config = function()
      -- Enable conceal for math blocks and formatting
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_follow_anchor = 1

      -- Adjust conceallevel for markdown files only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
        end,
      })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      vim.g.table_mode_corner = "|"

      -- Add table mode keymaps for markdown
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
      -- Add Nabla keymaps for LaTeX previews
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>ml", function()
            require("nabla").popup()
          end, { desc = "Preview LaTeX formula", buffer = true })
          vim.keymap.set("n", "<leader>ms", function()
            require("nabla").toggle_virt()
          end, { desc = "Toggle inline LaTeX preview", buffer = true })
        end,
      })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes/neorg",
              },
              default_workspace = "notes",
            },
          },
        },
      })
    end,
  },
}
