return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on these event (open file)
  main = "ibl",
  opts = {
    indent = { char = "┊" },
  }
}
