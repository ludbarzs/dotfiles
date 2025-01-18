return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
    -- Disable the default keymap for searching files
    {"<leader>/", false},
    
    -- Change the keymap for finding files
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },

    -- Add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },

    -- Add a keymap to browse files with Ctrl + p
    { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find Files with Ctrl+p" },
  }
    }
