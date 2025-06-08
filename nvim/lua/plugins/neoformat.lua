return {
    "sbdchd/neoformat",
    config = function()
        vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = { "*.js", "*.cs", "*.zig", "*.html" },
            command = "Neoformat"
        })
    end
}

-- npm install -g prettier
