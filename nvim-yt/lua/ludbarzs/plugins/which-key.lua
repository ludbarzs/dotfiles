return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function() 
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave empty to use default settings
  }
}
