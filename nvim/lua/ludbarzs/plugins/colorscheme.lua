return {
  "rebelot/kanagawa.nvim",
  lazy = false, -- Load during startup since it's the main colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("kanagawa").setup({
      theme = "dragon", -- Swaps the default gray for your deep charcoal/olive vibe
      transparent = false,
      dimInactive = true,
    })
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
