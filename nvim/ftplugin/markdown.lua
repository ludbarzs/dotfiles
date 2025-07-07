vim.opt_local.wrap = true -- Enable soft line wrapping
vim.opt_local.linebreak = true -- Wrap at word boundaries (not mid-word)
vim.opt_local.breakindent = true -- Preserve indentation on wrapped lines

-- Use `j`/`k` to move by logical lines (actual lines) when a count is given (e.g., `8j`)
-- Use `gj`/`gk` to move by visual lines (wrapped lines) otherwise
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, buffer = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, buffer = true })
