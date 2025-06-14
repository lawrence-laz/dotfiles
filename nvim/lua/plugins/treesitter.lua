return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        enabled = false,
        opts = { mode = "cursor" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        enabled = true,
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        -- dependencies = {
        --     { "nvim-treesitter/nvim-treesitter-textobjects", },
        --     { "windwp/nvim-ts-autotag",                      opts = {} },
        --     { 'JoosepAlviste/nvim-ts-context-commentstring' },
        -- },
        cmd = { "TSUpdateSync" },
        keys = {
            -- { "<C-w>",   desc = "Increment selection" },
            -- { "<C-S-w>", desc = "Decrement selection", mode = "x" },
        },
        opts = {

            -- indent = { enable = true },

            indent = {
                enable = false,
                disable = { "zig" }
            },

            autotag = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "c",
                "c_sharp",
                "cpp",
                "yaml",
                "css",
                "diff",
                "dockerfile",
                "gitcommit",
                "glsl",
                "svelte",
                "html",
                "http",
                "java",
                "javascript",
                "jq",
                "jsdoc",
                "json",
                "json5",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "ruby",
                "rust",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "zig",
            },
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
                enable = false,
                keymaps = -- nil,
                {
                    -- init_selection = '<C-w>',
                    scope_incremental = false, --'<CR>',
                    -- node_incremental = '<C-w>',
                    -- node_decremental = '<C-S-w>',
                },
            },
            -- context_commentstring = {
            -- 	enable = true,
            -- 	enable_autocmd = false,
            -- },
        },
        config = function(lazy, opts)
            require 'nvim-treesitter.configs'.setup(opts)
        end,
    }
}
