return {
  'windwp/nvim-autopairs',
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autoparis = require("nvim-autopairs")
    
    -- configure autoparis
    autoparis.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua srtring treesitter nodes
        javascript = { "template_string" }, -- dont add paris on JS template_string treesitter ndoes
        java = false, -- don't check treesitter on java
      }
    })

    -- import nvim-autopairs copletion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cpm plugin
    local cmp = require("cmp")

    -- make autoparis and completion work together
    cmp.event:on("config_done", cmp_autopairs.on_confirm_done())
  end,

  event = "InsertEnter",
  config = true,
}
