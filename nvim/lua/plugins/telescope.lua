return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-dap.nvim' },
    config = function(_, opts)
        local actions = require 'telescope.actions'
        require 'telescope'.setup({
            defaults = {
                -- vimgrep_arguments = {
                -- 	'rg',
                -- 	'--color=never',
                -- 	'--no-heading',
                -- 	'--with-filename',
                -- 	'--line-number',
                -- 	'--column',
                -- 	'--smart-case',
                -- 	'--hidden',
                -- },
                file_ignore_patterns = {
                    "%.git", ".cache", "%.o", "%.a", "%.out", "%.class",
                    "%.pdf", "%.mkv", "%.mp4", "%.zip"
                },
                mappings = {
                    n = {
                        -- I've found that automatically openning the qflist is quite annoying
                        -- and usually needs to be closed.
                        -- It's easier to just do `gqq` and open when needed.
                        ["<C-q>"] = actions.smart_send_to_qflist -- + actions.open_qflist,
                    },
                    i = {
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<C-q>"] = actions.smart_send_to_qflist -- + actions.open_qflist,
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                    -- find_command = { "echo" },
                },
                live_grep = {
                    additional_args = function(_ts)
                        return { "--hidden" }
                    end
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
        })
        require('telescope').load_extension('dap')
        require('telescope').load_extension('fzf')
    end,
}
