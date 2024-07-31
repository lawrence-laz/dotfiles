return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
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
                    ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
                    "%.pdf", "%.mkv", "%.mp4", "%.zip"
                },
                mappings = {
                    n = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                    i = {
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
                live_grep = {
                    additional_args = function(_ts)
                        return { "--hidden" }
                    end
                },
            },
        })
        require('telescope').load_extension('dap')
    end,
}
