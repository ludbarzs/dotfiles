return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs", -- TS has its own jjmodule to be defined in setup(), which this does
  opts = {
    ensure_installed = {
      "lua",
      "markdown",
      "norg",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- TODO: set Vhyrrro keybindings
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

  }
}
