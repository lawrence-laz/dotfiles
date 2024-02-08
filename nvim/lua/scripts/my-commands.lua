local pickers = require "telescope.pickers"            -- Main module which is used to create a new picker
local finders = require "telescope.finders"            -- Provides interfaces to fill the picker with items
local conf = require("telescope.config").values        -- User configuration
local actions = require "telescope.actions"            -- Holds all actions that can be mapped by a user
local action_state = require "telescope.actions.state" -- Gives us a few utility functions we can use to get the current picker, current selection or current line

package.loaded['scripts.my-commands'] = nil

local commands = {
    {
        name = "Code: Format",
        exec = vim.lsp.buf.format,
        keymap = { "n", "<leader>kd" }
    },
    {
        name = "Code: Show outline",
        exec = "Lspsaga outline",
    },
    {
        name = "Code: Find usages",
        exec = "Lspsaga finder ref",
        keymap = { "n", "gu" }
    },
    {
        name = "Code: Find implementations",
        exec = "Lspsaga finder imp",
        keymap = { "n", "gi" }
    },
    {
        name = "Code: Go to definition",
        exec = "Lspsaga goto_definition",
        keymap = { "n", "gd" }
    },
    {
        name = "Code: Generate documentation",
        exec = ':execute "normal \\<Plug>(doge-generate)"',
    },
    {
        name = "Diagnostics: Show for current file",
        exec = "Lspsaga show_buf_diagnostics",
    },
    {
        name = "Diagnostics: Show for workspace",
        exec = "Lspsaga show_workspace_diagnostics",
    },
    {
        name = "Git: Blame",
        exec = require 'gitsigns'.blame_line,
        keymap = { "n", "<leader>gb" }
    },
    {
        name = "Git: Diff this",
        exec = require 'gitsigns'.diffthis,
    },
    {
        name = "Git: Toggle blame",
        exec = require 'gitsigns'.toggle_current_line_blame
    },
    {
        name = "Git: Toggle deleted",
        exec = require 'gitsigns'.toggle_deleted
    },
    {
        name = "Git: Next hunk",
        exec = require 'gitsigns'.next_hunk,
        keymap = { "n", "<leader>gn" }
    },
    {
        name = "Git: Previous hunk",
        exec = require 'gitsigns'.prev_hunk,
        keymap = { "n", "<leader>gN" }
    },
    {
        name = "Git: Preview hunk",
        exec = require 'gitsigns'.preview_hunk_inline,
        keymap = { "n", "<leader>gp" }
    },
    {
        name = "Git: Reset hunk",
        exec = require 'gitsigns'.reset_hunk,
        keymap = { "n", "<leader>gD" }
    },
    {
        name = "Git: Open",
        exec = "LazyGit",
        keymap = { "n", "<leader>gg" }
    },
    {
        name = "Git: Current file history",
        exec = "DiffviewFileHistory %",
    },
    {
        name = "Git: Current branch history",
        exec = "DiffviewFileHistory",
    },
    {
        name = "Git: Current changes",
        exec = "DiffviewOpen",
    },
    {
        name = "Quickfix: Show",
        exec = "copen",
    },
    {
        name = "Quickfix: Close",
        exec = "cclose",
    },
    {
        name = "Quickfix: Next",
        exec = "cnext",
    },
    {
        name = "Quickfix: Previous",
        exec = "cprev",
    },
    {
        name = "Quickfix: First",
        exec = "cfirst",
    },
    {
        name = "Quickfix: Last",
        exec = "clast",
    },
    {
        name = "View: Diagnostics in workspace",
        exec = function()
            if vim.bo.filetype == 'Trouble' then
                vim.cmd [[TroubleToggle]]
            else
                vim.cmd [[Trouble workspace_diagnostics]]
            end
        end,
        keymap = { "n", "<leader>ve" },
    },
    {
        name = "Go to: Next error",
        exec = function()
            if vim.bo.filetype ~= 'Trouble' then
                vim.cmd [[Trouble]]
            end
            require 'trouble'.next({ skip_groups = true, jump = true })
        end,
        keymap = { "n", "ge" },
    },
    {
        name = "Go to: Previous error",
        exec = function()
            if vim.bo.filetype ~= 'Trouble' then
                vim.cmd [[Trouble]]
            end
            require 'trouble'.previous({ skip_groups = true, jump = true })
        end,
        keymap = { "n", "gE" },
    },
    {
        desc = "Show: Diagnostics in document",
        exec = "TroubleToggle document_diagnostics",
    },
    {
        -- Doesn't work, but not sure if needed.
        desc = "Search: Diagnostics (warnings and errors)",
        exec = function()
            require("telescope.builtin").diagnostics({ severity_limit = "warn" })
        end,
        keymap = { "n", "gfe" },
    },
    {
        name = "Test: Run nearest",
        exec = function()
            vim.cmd [[w]]
            require("neotest").run.run()
        end,
        keymap = { "n", "<leader>tr" }
    },
    {
        name = "Test: Show output",
        exec = require 'neotest'.output.open,
        keymap = { "n", "<leader>to" }
    },
    {
        name = "Increment selection",
        exec = require 'nvim-treesitter.incremental_selection'.node_incremental,
        -- todo: use something wiht v? or visual only, right?
        -- keymap = { "v", "<C-w>" },
    },
    {
        name = "Decrement selection",
        exec = require 'nvim-treesitter.incremental_selection'.node_decremental,
        -- keymap = { "v", "<C-S-w>" },
    },
    {
        name = "Search help",
        exec = "Telescope help_tags"
    },
    {
        name = "Casing: To 'UPPER CASE'",
        exec = function() require('textcase').current_word('to_upper_case') end,
    },
    {
        name = "Casing: To 'lower case'",
        exec = function() require('textcase').current_word('to_lower_case') end,
    },
    {
        name = "Casing: To 'snake_case'",
        exec = function() require('textcase').current_word('to_snake_case') end,
    },
    {
        name = "Casing: To 'dash-case'",
        exec = function() require('textcase').current_word('to_dash_case') end,
    },
    {
        name = "Casing: To 'CONSTANT_CASE'",
        exec = function() require('textcase').current_word('to_constant_case') end,
    },
    {
        name = "Casing: To 'dot.case'",
        exec = function() require('textcase').current_word('to_dot_case') end,
    },
    {
        name = "Casing: To 'Phrase case'",
        exec = function() require('textcase').current_word('to_phrase_case') end,
    },
    {
        name = "Casing: To 'camelCase'",
        exec = function() require('textcase').current_word('to_camel_case') end,
    },
    {
        name = "Casing: To 'PascalCase'",
        exec = function() require('textcase').current_word('to_pascal_case') end,
    },
    {
        name = "Casing: To 'Title Case'",
        exec = function() require('textcase').current_word('to_title_case') end,
    },
    {
        name = "Casing: To 'path/case'",
        exec = function() require('textcase').current_word('to_path_case') end,
    },
    {
        name = "Keymap: Show current",
        exec = function() vim.cmd([[redir @a | silent map | redir END | enew | put a]]) end,
    },
    {
        name = "Undo: Toggle undo tree",
        exec = vim.cmd.UndotreeToggle,
        keymap = { "n", "<leader>u" },
    },
    {
        name = "File: Show unsaved changes",
        exec = ":w !diff % -",
    },
    {
        name = "File: Type",
        exec = ":set filetype?",
    },
    {
        name = "File: Copy absolute path",
        exec = [[:!echo %:p | tr -d '\n' | pbcopy]],
        silent = true
    },
    {
        name = "Tab: Next",
        exec = ":tabnext",
        keymap = { "n", "<C-Tab>" },
    },
    {
        name = "Tab: Previous",
        exec = ":tabprev",
        keymap = { "n", "<C-S-Tab>" },
    },
    {
        name = "Bookmarks: Explore bookmarks",
        exec = require 'bookmarks'.toggle_bookmarks,
        keymap = { "n", "<leader>ke" }
    },
    {
        name = "Bookmarks: Add bookmark",
        exec = require 'bookmarks'.add_bookmarks,
    },
    {
        name = "Bookmarks: Show description",
        exec = require 'bookmarks.list'.show_desc,
        keymap = { "n", "<leader>kK" }
    },
    {
        name = "Bookmarks: Delete bookmark",
        exec = require 'bookmarks.list'.delete_on_virt,
    },
    {
        name = "Bookmarks: Toggle bookmark",
        exec = function()
            local data = require("bookmarks.data")
            -- local list = require("bookmarks.list")
            local line = vim.fn.line(".")
            local file_name = vim.api.nvim_buf_get_name(0)
            -- Try to delete.
            for k, v in pairs(data.bookmarks) do
                if v.line == line and file_name == v.filename then
                    if data.bookmarks_order_ids[line] ~= nil then
                        require("bookmarks").delete()
                        return
                    end
                end
            end
            -- Otherwise create a new one.
            require("bookmarks").add_bookmarks()
        end,
        keymap = { "n", "<leader>kk" }
    },
    {
        name = "View: Current LSP settings",
        exec = "Redir lua P(vim.lsp.get_active_clients())",
    },


    -- TODO: jump to next bookmark
    -- TODO: jump to previous bookmark
    -- TODO: explore bookmarks
    -- TODO: annotate bookmark?
    --require'bookmarks'.toggle_bookmarks()
}

local function set_keymaps()
    for _, command in ipairs(commands) do
        if command.keymap ~= nil and type(command.exec) == "string" then
            vim.keymap.set(command.keymap[1], command.keymap[2], "<cmd>" .. command.exec .. "<cr>")
        elseif command.keymap ~= nil and type(command.exec) == "function" then
            vim.keymap.set(command.keymap[1], command.keymap[2], command.exec)
        end
    end
end
set_keymaps()

local my_commands = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "my_commands",
        finder = finders.new_table {
            results = commands,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- print(vim.inspect(selection))
                -- vim.api.nvim_put({ selection[1] }, "", false, true)
                print(vim.inspect(selection.value.exec))
                if type(selection.value.exec) == "string" then
                    if (selection.value.silent) then
                        vim.cmd("silent" .. selection.value.exec)
                    else
                        vim.cmd(selection.value.exec)
                    end
                elseif type(selection.value.exec) == "function" then
                    -- print(vim.inspect(selection.value.exec))
                    selection.value.exec()
                end
            end)
            return true
        end,
    }):find()
end

local M = function()
    my_commands(require("telescope.themes").get_dropdown {})
end

return M
