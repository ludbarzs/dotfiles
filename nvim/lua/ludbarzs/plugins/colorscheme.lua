return {
	"joshdick/onedark.vim",
	priority = 1000,
	config = function()
		-- require("onedark").setup({
		-- 	style = "darker",
		-- })
		vim.cmd("colorscheme onedark")
	end,
}
