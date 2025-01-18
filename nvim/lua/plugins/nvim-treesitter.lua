local M = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end
    
}
M.config = function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "javascript", "python", "c", "c_sharp" },
        highlight = {
            enable = true,                      
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,                     
        },
    }
end

return { M }
