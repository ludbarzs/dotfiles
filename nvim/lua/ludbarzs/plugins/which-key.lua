return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    local which_key = require("which-key")
    which_key.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    })

    -- Create markdown-specific groups when in markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        local mappings = {
          ["<leader>m"] = {
            name = "Markdown",
            ["1"] = { "<cmd>normal! # <cr>", "H1 Header" },
            ["2"] = { "<cmd>normal! ## <cr>", "H2 Header" },
            ["3"] = { "<cmd>normal! ### <cr>", "H3 Header" },
            b = { "<cmd>normal! ****<Left><Left><cr>", "Bold Text" },
            c = { "<cmd>setlocal conceallevel=<C-R>=&conceallevel == 0 ? '2' : '0'<CR><CR>", "Toggle Conceal" },
            d = { "<cmd>put =strftime('%Y-%m-%d')<CR>", "Insert Date" },
            i = { "<cmd>normal! **<Left><cr>", "Italic Text" },
            k = { "<cmd>normal! - [ ] <cr>", "Add Task" },
            l = { "<cmd>MarkdownPreviewLatex<cr>", "Preview LaTeX" },
            m = { "<cmd>normal! $$<Left><cr>", "Inline Math" },
            o = { "<cmd>normal! 0f[lrx<cr>", "Mark Task Open" },
            p = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Preview" },
            s = { "<cmd>setlocal spell!<cr>", "Toggle Spell" },
            t = { "<cmd>put =strftime('%H:%M')<CR>", "Insert Time" },
            x = { "<cmd>normal! 0f[lr]<cr>", "Complete Task" },
            z = { "<cmd>MarkdownPreviewMathToggle<cr>", "Toggle Math Preview" },
            ["`"] = { "<cmd>normal! ```<CR>```<ESC>O", "Code Block" },
            ["$"] = { "<cmd>normal! $$<CR>$$<ESC>O", "Math Block" },
          },
          ["<leader>t"] = {
            name = "Table",
            m = { "<cmd>TableModeToggle<cr>", "Toggle Table Mode" },
            f = { "<cmd>TableFormat<cr>", "Format Table" },
          },
          ["<leader>o"] = {
            name = "Obsidian",
            n = { "<cmd>ObsidianNew<cr>", "New Note" },
            t = { "<cmd>ObsidianToday<cr>", "Today's Note" },
            y = { "<cmd>ObsidianYesterday<cr>", "Yesterday's Note" },
            o = { "<cmd>ObsidianOpen<cr>", "Open in Obsidian" },
            f = { "<cmd>ObsidianQuickSwitch<cr>", "Find Notes" },
            s = { "<cmd>ObsidianSearch<cr>", "Search Notes" },
            b = { "<cmd>ObsidianBacklinks<cr>", "Show Backlinks" },
            l = { "<cmd>ObsidianFollowLink<cr>", "Follow Link" },
          },
          ["<leader>f"] = {
            name = "Find",
            n = { "<cmd>ObsidianQuickSwitch<cr>", "Find Notes" },
            g = { "<cmd>ObsidianSearch<cr>", "Search in Notes" },
          },
        }
      end,
    })
  end,
}
