return {
	root_dir = function(bufnr, on_dir)
		-- Only activate ts_ls if there's NO deno config
		if not vim.fs.root(bufnr, { "deno.json", "deno.jsonc" }) then
			-- Look for TypeScript/Node.js project markers
			local root = vim.fs.root(bufnr, { "tsconfig.json", "package.json", "jsconfig.json", "bun.lockb", ".git" })
			if root then
				on_dir(root)
			end
		end
	end,
}
