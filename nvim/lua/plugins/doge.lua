return {
    "kkoomen/vim-doge",
    enabled = false,
    build = function()
        vim.cmd [[call doge#install()]]
    end
}
