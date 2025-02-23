return {
	"ThePrimeagen/harpoon",
	config = function()
		local harpoon_mark = require("harpoon.mark")
		local harpoon_ui = require("harpoon.ui")

		-- Keybindings
		vim.keymap.set("n", "<leader>a", harpoon_mark.add_file, { desc = "Harpoon: Add File" })
		vim.keymap.set("n", "<C-e>", harpoon_ui.toggle_quick_menu, { desc = "Harpoon: Open menu" })

		vim.keymap.set("n", "<C-h>", function()
			harpoon_ui.nav_file(1)
		end, { desc = "Harpoon File 1" })
		vim.keymap.set("n", "<C-j>", function()
			harpoon_ui.nav_file(2)
		end, { desc = "Harpoon File 2" })
		vim.keymap.set("n", "<C-k>", function()
			harpoon_ui.nav_file(3)
		end, { desc = "Harpoon File 3" })
		vim.keymap.set("n", "<C-l>", function()
			harpoon_ui.nav_file(4)
		end, { desc = "Harpoon File 4" })
	end,
}
