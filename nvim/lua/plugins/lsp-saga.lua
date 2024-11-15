return {
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            local lspsaga = require 'lspsaga'
            lspsaga.setup({
                lightbulb = {
                    enable = false,
                    enable_in_insert = false,
                    sign = false,
                    sign_priority = 40,
                    virtual_text = false,
                },
                code_action = {
                    keys = {
                        quit = { 'q', '<ESC>' },
                    },
                },
                diagnostic = {
                    keys = {
                        exec_action = 'o',
                        quit = { 'q', '<ESC>' },
                        toggle_or_jump = '<CR>',
                        quit_in_show = { 'q', '<ESC>' },
                    }
                },
                finder = {
                    layout = 'float', -- or normal
                    keys = {
                        shuttle = {
                            '[w',
                            -- '<C-l>', -- Conflicts with pane navigation
                            -- '<C-h>' -- Conflicts with pane navigation
                        },
                        toggle_or_open = { 'o', '<CR>' },
                        vsplit = { 's', '|' },
                        split = { 'i', '-' },
                        tabe = 't',
                        tabnew = 'r',
                        quit = { 'q', '<ESC>' },
                        close = '<C-c>k',
                    },
                },
                rename = {
                    keys = {
                        quit = { '<C-k>', '<ESC>' },
                        exec = '<CR>',
                        select = 'x',
                    },
                },
                outline = {
                    keys = {
                        toggle_or_jump = { 'o', '<CR>' },
                        quit = 'q',
                        jump = 'e',
                    },
                }
            })
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        }
    }
}
