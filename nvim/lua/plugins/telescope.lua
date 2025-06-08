return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-dap.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        {
            'nvim-telescope/telescope-live-grep-args.nvim',
            version = "^1.0.0",
        }
    },
    config = function(_, opts)
        local telescope = require 'telescope'
        local actions = require 'telescope.actions'
        local lga_actions = require("telescope-live-grep-args.actions")
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
                },
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = actions.to_fuzzy_refine,
                        },
                    },
                    -- ... also accepts theme settings, for example:
                    -- theme = "dropdown", -- use dropdown theme
                    -- theme = { }, -- use own theme spec
                    -- layout_config = { mirror=true }, -- mirror preview pane
                },
            },
        })
        telescope.load_extension('dap')
        telescope.load_extension('fzf')
        telescope.load_extension("live_grep_args")
    end,
}
