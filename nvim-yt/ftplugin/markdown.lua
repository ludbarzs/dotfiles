-- File-specific settings for Markdown files

-- Set options for markdown files
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- Set up custom math snippets extension using LuaSnip
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

-- Math snippets for inline and display math
luasnip.add_snippets("markdown", {
  -- Inline math: $...$
  s("im", {
    t("$"),
    i(1),
    t("$"),
  }),

  -- Display math: $$...$$
  s("dm", {
    t("$$"),
    i(1),
    t("$$"),
  }),

  -- Common math environments
  s("eqn", {
    t("$$"),
    i(1),
    t("$$"),
  }),

  s("align", {
    t("$$\\begin{align}"),
    t({ "", "" }),
    i(1),
    t({ "", "" }),
    t("\\end{align}$$"),
  }),

  -- Greek letters
  s("alpha", { t("\\alpha") }),
  s("beta", { t("\\beta") }),
  s("gamma", { t("\\gamma") }),
  s("delta", { t("\\delta") }),
  s("epsilon", { t("\\epsilon") }),
  s("zeta", { t("\\zeta") }),
  s("eta", { t("\\eta") }),
  s("theta", { t("\\theta") }),
  s("iota", { t("\\iota") }),
  s("kappa", { t("\\kappa") }),
  s("lambda", { t("\\lambda") }),
  s("mu", { t("\\mu") }),
  s("nu", { t("\\nu") }),
  s("xi", { t("\\xi") }),
  s("pi", { t("\\pi") }),
  s("rho", { t("\\rho") }),
  s("sigma", { t("\\sigma") }),
  s("tau", { t("\\tau") }),
  s("upsilon", { t("\\upsilon") }),
  s("phi", { t("\\phi") }),
  s("chi", { t("\\chi") }),
  s("psi", { t("\\psi") }),
  s("omega", { t("\\omega") }),

  -- Common math symbols
  s("sum", { t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("}") }),
  s("prod", { t("\\prod_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("}") }),
  s("lim", { t("\\lim_{"), i(1, "n \\to \\infty"), t("}") }),
  s("int", { t("\\int_{"), i(1, "a"), t("}^{"), i(2, "b"), t("} "), i(3), t(" \\, d"), i(4, "x") }),
  s("frac", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }),
  s("sqrt", { t("\\sqrt{"), i(1), t("}") }),
  s("^", { t("^{"), i(1), t("}") }),
  s("_", { t("_{"), i(1), t("}") }),

  -- Matrix
  s("bmat", {
    t("\\begin{bmatrix} "),
    i(1),
    t(" & "),
    i(2),
    t(" \\\\ "),
    i(3),
    t(" & "),
    i(4),
    t(" \\end{bmatrix}"),
  }),

  -- Derivatives
  s("dd", { t("\\frac{d"), i(1, "y"), t("}{d"), i(2, "x"), t("}") }),
  s("pp", { t("\\frac{\\partial "), i(1, "y"), t("}{\\partial "), i(2, "x"), t("}") }),

  -- Mermaid diagrams
  s("mmd", {
    t({ "```mermaid", "" }),
    i(1, "graph TD;"),
    t({ "", "```" }),
  }),

  -- Special blocks
  s("note", {
    t({ ":::note", "" }),
    i(1, "Note content"),
    t({ "", ":::" }),
  }),

  s("warn", {
    t({ ":::warning", "" }),
    i(1, "Warning content"),
    t({ "", ":::" }),
  }),

  -- Daily note template
  s("daily", {
    t({ "# Daily Note: " }),
    i(1, os.date("%Y-%m-%d")),
    t({ "", "", "## Tasks", "", "- [ ] " }),
    i(2, "First task"),
    t({ "", "", "## Notes", "", "" }),
    i(3),
    t({ "", "", "## Thoughts", "", "" }),
    i(4),
  }),
})

-- Keyboard mappings for markdown-specific functionality
local keymap = vim.keymap

-- Toggle markdown features
keymap.set("n", "<leader>mc", function()
  vim.opt_local.conceallevel = vim.opt_local.conceallevel:get() == 0 and 2 or 0
end, { desc = "Toggle Markdown Conceal", buffer = true })
keymap.set("n", "<leader>ms", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle Spell Check", buffer = true })

-- Insert date/timestamp
keymap.set("n", "<leader>md", function()
  local date = os.date("%Y-%m-%d")
  vim.api.nvim_put({ date }, "", false, true)
end, { desc = "Insert Date", buffer = true })

keymap.set("n", "<leader>mt", function()
  local timestamp = os.date("%H:%M")
  vim.api.nvim_put({ timestamp }, "", false, true)
end, { desc = "Insert Time", buffer = true })

-- Create/manage tasks
keymap.set("n", "<leader>mk", "o- [ ] ", { desc = "Add New Task", buffer = true })
keymap.set("n", "<leader>mx", "^f[lrx", { desc = "Complete Task", buffer = true })
keymap.set("n", "<leader>mo", "^f[lr ", { desc = "Incomplete Task", buffer = true })

-- Create headers
keymap.set("n", "<leader>m1", "I# <Esc>", { desc = "H1 Header", buffer = true })
keymap.set("n", "<leader>m2", "I## <Esc>", { desc = "H2 Header", buffer = true })
keymap.set("n", "<leader>m3", "I### <Esc>", { desc = "H3 Header", buffer = true })

-- Format text
keymap.set("n", "<leader>mb", 'ciw**<C-r>"**<Esc>', { desc = "Bold Text", buffer = true })
keymap.set("n", "<leader>mi", 'ciw*<C-r>"*<Esc>', { desc = "Italic Text", buffer = true })
keymap.set("v", "<leader>mb", 'c**<C-r>"**<Esc>', { desc = "Bold Selection", buffer = true })
keymap.set("v", "<leader>mi", 'c*<C-r>"*<Esc>', { desc = "Italic Selection", buffer = true })

-- Insert code blocks
keymap.set("n", "<leader>m`", "i```<CR>```<Esc>O", { desc = "Insert Code Block", buffer = true })
keymap.set("n", "<leader>mj", "i```javascript<CR>```<Esc>O", { desc = "Insert JS Code Block", buffer = true })
keymap.set("n", "<leader>mp", "i```python<CR>```<Esc>O", { desc = "Insert Python Code Block", buffer = true })
keymap.set("n", "<leader>ml", "i```lua<CR>```<Esc>O", { desc = "Insert Lua Code Block", buffer = true })

-- Math specific
keymap.set("n", "<leader>m$", "i$$<CR>$$<Esc>O", { desc = "Insert Math Block", buffer = true })
keymap.set("n", "<leader>mm", "i$<Esc>Ea$<Esc>", { desc = "Insert Inline Math", buffer = true })

-- Fold headings
keymap.set("n", "<leader>z", "zM", { desc = "Fold All Headers", buffer = true })
keymap.set("n", "<leader>Z", "zR", { desc = "Unfold All Headers", buffer = true })

-- Set up Telescope integration for notes
keymap.set("n", "<leader>fn", "<cmd>Telescope find_files cwd=~/notes<CR>", { desc = "Find Notes", buffer = true })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep cwd=~/notes<CR>", { desc = "Search in Notes", buffer = true })
