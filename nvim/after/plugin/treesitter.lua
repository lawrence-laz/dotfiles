require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "bash", "c_sharp", "cpp", "css", "diff",
        "dockerfile", "gitcommit", "glsl", "html", "http", "java", "jq", "jsdoc", "json", "markdown", "markdown_inline",
        "python", "regex", "ruby", "vim", "yaml" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-w>',
            scope_incremental = '<CR>',
            node_incremental = '<C-w>',
            node_decremental = '<C-S-w>',
        },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}
