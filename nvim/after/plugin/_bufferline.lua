-- Tabs
require("bufferline").setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
            close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
            middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
            indicator = {
                --icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'none', --'icon' | 'underline' | 'none',
            },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            --- name_formatter can be used to change the buffer's label in the bufferline.
            --- Please note some names can/will break the
            --- bufferline so use this at your discretion knowing that it has
            --- some limitations that will *NOT* be fixed.
            name_formatter = function(buf)  -- buf contains:
                -- name                | str        | the basename of the active file
                -- path                | str        | the full path of the active file
                -- bufnr (buffer only) | int        | the number of the active buffer
                -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
                -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
            end,
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true, -- whether or not tab names should be truncated
            --tab_size = 18,
            diagnostics = 'nvim_lsp', --false | "nvim_lsp" | "coc",
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = function(buf_number, buf_numbers)
                -- filter out filetypes you don't want to see
                if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                    return true
                end
                -- filter out by buffer name
                if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    return true
                end
                -- filter out based on arbitrary rules
                -- e.g. filter out vim wiki buffer from tabline in your work repo
                if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                    return true
                end
                -- filter out by it's index number in list (don't show first buffer)
                if buf_numbers[1] ~= buf_number then
                    return true
                end
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    --text_align = "left" | "center" | "right"
                    --separator = true
                }
            },
            --color_icons = true | false, -- whether or not to add the filetype icon highlights
            --show_buffer_icons = true | false, -- disable filetype icons for buffers
            --show_buffer_close_icons = true | false,
            --show_buffer_default_icon = true | false, -- whether or not an unrecognised filetype should show a default icon
            --show_close_icon = true | false,
            --show_tab_indicators = true | false,
            --show_duplicate_prefix = true | false, -- whether to show duplicate buffer prefix
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = 'slant', --"slant" | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
        }
    }

vim.keymap.set("n", "<A-1>", function() require'bufferline'.go_to_buffer(1, true) end) -- Open 1st tab
vim.keymap.set("n", "<A-2>", function() require'bufferline'.go_to_buffer(2, true) end) -- Open 2nd tab
vim.keymap.set("n", "<A-3>", function() require'bufferline'.go_to_buffer(3, true) end) -- Open 3rd tab
vim.keymap.set("n", "<A-4>", function() require'bufferline'.go_to_buffer(4, true) end) -- Open 4th tab
vim.keymap.set("n", "<A-5>", function() require'bufferline'.go_to_buffer(5, true) end) -- Open 5th tab
vim.keymap.set("n", "<A-6>", function() require'bufferline'.go_to_buffer(6, true) end) -- Open 6th tab
vim.keymap.set("n", "<A-7>", function() require'bufferline'.go_to_buffer(7, true) end) -- Open 7th tab
vim.keymap.set("n", "<A-8>", function() require'bufferline'.go_to_buffer(8, true) end) -- Open 8th tab
vim.keymap.set("n", "<A-9>", function() require'bufferline'.go_to_buffer(9, true) end) -- Open 9th tab

vim.keymap.set("n", "<C-tab>", "<cmd>BufferLineCycleNext<CR>") -- Open next tab
vim.keymap.set("n", "<C-S-tab>", "<cmd>BufferLineCyclePrev<CR>") -- Open previous tab
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>") -- New tab
vim.keymap.set("n", "<C-F4>", "<cmd>bdelete! %<CR>") -- Close tab
