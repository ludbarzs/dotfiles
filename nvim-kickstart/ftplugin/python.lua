local function run_curr_python_file()
  -- Get file name in the current buffer
  local file_name = vim.api.nvim_buf_get_name(0)

  -- Find project root (looks for setup.py, pyproject.toml, or .git)
  local root_markers = { 'setup.py', 'pyproject.toml', '.git' }
  local current_dir = vim.fn.expand '%:p:h' -- Get the directory of the current file

  local function find_project_root(dir)
    for _, marker in ipairs(root_markers) do
      if vim.fn.filereadable(dir .. '/' .. marker) == 1 or vim.fn.isdirectory(dir .. '/' .. marker) == 1 then
        return dir
      end
    end
    local parent = vim.fn.fnamemodify(dir, ':h')
    if parent == dir then
      return nil
    end -- Stop at filesystem root
    return find_project_root(parent) -- Recursively check parent directories
  end

  local project_root = find_project_root(current_dir) or current_dir

  -- Change to project root
  local cd_cmd = 'cd ' .. vim.fn.fnameescape(project_root) .. ' && '

  -- Python command
  local py_cmd = vim.api.nvim_replace_termcodes('i' .. cd_cmd .. 'python "' .. file_name .. '"<cr>', true, false, true)

  -- Open terminal and run command
  local term_height = math.floor(vim.api.nvim_win_get_height(0) * 0.4)
  vim.cmd(':below ' .. term_height .. 'split | term') -- Open terminal in horizontal split
  vim.api.nvim_feedkeys(py_cmd, 't', false) -- Run Python script in project root
end

vim.keymap.set({ 'n' }, '<A-r>', '', {
  desc = 'Run .py file via Neovim built-in terminal from project root',
  callback = run_curr_python_file,
})
