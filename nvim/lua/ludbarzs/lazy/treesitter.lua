return {
   'nvim-treesitter/nvim-treesitter',
   build = ':TSUpdate',
   opts = {
	   ensure_installed = {
		   'help', 'javascript', 'typescript', 'bash', 'c', 'lua', 'python', 'vim', 'vimdocs'
	}
   },
   auto_install = true,
   highlight = {
	   enable = true,
	   additional_vim_regex_highlighting = false,
   },
}
