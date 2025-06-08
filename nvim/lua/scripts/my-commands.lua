local pickers = require "telescope.pickers"            -- Main module which is used to create a new pickermycomm
local finders = require "telescope.finders"            -- Provides interfaces to fill the picker with items
local conf = require("telescope.config").values        -- User configuration
local actions = require "telescope.actions"            -- Holds all actions that can be mapped by a user
local action_state = require "telescope.actions.state" -- Gives us a few utility functions we can use to get the current picker, current selection or current line

package.loaded['scripts.my-commands'] = nil

local dap_scopes = function()
    local widgets = require 'dap.ui.widgets'; widgets.centered_float(widgets.scopes)
end

--[[

You could also customize the buffer and window creation using a low-level builder:

>lua
  local widgets = require('dap.ui.widgets')
  widgets.builder(widgets.scopes)
    .new_buf(function_that_creates_and_returns_a_buffer)
    .new_win(function_that_creates_and_returns_a_window)
    .build()


  vim.wo[winnr].cursorline = true


  local bufnr, winnr = lsp_util.open_floating_preview(
    markdown_lines,
    'markdown',
    vim.tbl_extend('keep', win_opt, {
      focusable = true,
      focus_id = 'rust-analyzer-hover-actions',
      close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
    })
  )


--]]

local dap_hover_better = function(expr, winopts)
    local widgets = require 'dap.ui.widgets'
    local lsp_util = require 'vim.lsp.util'



    local new_hover_win = function()
        local bufnr, winnr = lsp_util.open_floating_preview(
            { 'start' },
            'markdown',
            vim.tbl_extend('keep', {}, {
                focusable = true,
                focus_id = 'dap-hover',
                close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
            })
        )
        return winnr
    end

    -- new_hover_win();

    -- local value = eval_expression(expr)
    --
    local view = widgets.builder(widgets.expression)
        .new_win(widgets.with_resize(new_hover_win))
        .build()
    -- local buf = view.open(value)
    local buf = view.open()
    -- api.nvim_buf_set_name(buf, 'dap-hover-' .. tostring(buf) .. ': ' .. value)
    -- api.nvim_win_set_cursor(view.win, { 1, 0 })
    return view
end

local dap_hover = function()
    -- function M.new_cursor_anchored_float_win(buf)
    --     vim.bo[buf].bufhidden = "wipe"
    --     vim.bo[buf].filetype = "dap-float"
    --     local opts = vim.lsp.util.make_floating_popup_options(50, 30, { border = 'single' })
    --     local win = api.nvim_open_win(buf, false, opts)
    --     vim.wo[win].scrolloff = 0
    --     return win
    -- end
    -- vim.lsp.util.open_floating_preview({ "hello" }, "dap-float", {
    --     focusable = true,
    --     close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
    --     focus_id = 'dappp',
    --     width = 50,
    --     height = 5,
    -- })

    -- if (baar == nil) then
    baar = require 'dap.ui.widgets'.hover()
    -- else
    --     -- vim.api.nvim_set_current_win(baar.win)
    --     local bufnr, win = vim.lsp.util.open_floating_preview({ "kitas" }, "dap-float", {
    --         focusable = true,
    --         -- close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
    --         close_events = {},
    --         focus_id = 'dappp',
    --         focus = true,
    --         width = 50,
    --         height = 5,
    --     })
    -- end
    -- require 'dap.ui.widgets'.scopes
    -- vim.lsp.buf.hover()
    -- vim.lsp.util.open_floating_preview()
    P(vim.api.nvim_list_wins())
end

local dap_goto = function()
    require 'dap'.goto_(vim.api.nvim_win_get_cursor(0)[1])
end

local dap_list_breapoints = function()
    require 'dap'.list_breakpoints(true)
end

local toggle_quickfix = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo() or {}) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    -- if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
    -- end
end

local commands = {
    {
        name = "Buffer: Close current",
        exec = "Bdelete",
        keymap = { "n", "<leader>q" },
    },
    {
        name = "Buffer: Close current FORCE",
        exec = "Bdelete!",
        keymap = { "n", "<leader>Q" },
    },
    {
        name = "Buffer: Close all",
        exec = "bufdo :Bdelete",
    },
    {
        name = "Code: Format",
        exec = function()
            if (vim.bo.filetype == "cs") then
                vim.cmd(":Neoformat csharpier")
            elseif (vim.bo.filetype == "javascript") then
                vim.cmd(":Neoformat prettier")
            else
                vim.lsp.buf.format()
            end
        end,
        keymap = { "n", "<leader>kd" }
    },
    {
        name = "Code: Show outline",
        exec = "Lspsaga outline",
    },
    {
        name = "Code: Find usages",
        exec = "Telescope lsp_references initial_mode=normal",
        keymap = { "n", "gu" }
    },
    {
        name = "Code: Find implementations",
        exec = "Lspsaga finder imp",
        keymap = { "n", "gi" }
    },
    {
        name = "Code: Go to definition",
        -- exec = "Lspsaga goto_definition", -- Lspsaga keeps saying "request was already sent, please wait".
        exec = vim.lsp.buf.definition,
        keymap = { "n", "gd" }
    },
    {
        name = "Code: Generate documentation",
        exec = ':execute "normal \\<Plug>(doge-generate)"',
    },
    {
        name = "Document: Find symbol",
        exec = "Telescope lsp_document_symbols",
        keymap = { "n", "<C-,>" }
    },
    -- run to cursor
    { name = "Debug: Run",                  exec = require 'dap'.continue,          keymap = { "n", "drr" } },
    { name = "Debug: Continue",             exec = require 'dap'.continue,          keymap = { "n", "dc" } },
    { name = "Debug: Run last",             exec = require 'dap'.run_last,          keymap = { "n", "drl" } },
    { name = "Debug: Quit",                 exec = require 'dap'.terminate,         keymap = { "n", "dq" } },
    { name = "Debug: Go to current line",   exec = require 'dap'.focus_frame, },
    { name = "Debug: Open REPL",            exec = require 'dap'.repl.open, },
    { name = "Debug: Variables (scopes)",   exec = dap_scopes,                      keymap = { "n", "dv" } },
    { name = "Debug: Toggle breakpoint",    exec = require 'dap'.toggle_breakpoint, keymap = { "n", "dh" } },
    { name = "Debug: Step over",            exec = require 'dap'.step_over,         keymap = { "n", "dj" } },
    { name = "Debug: Run to cursor",        exec = require 'dap'.run_to_cursor,     keymap = { "n", "dJ" } },
    { name = "Debug: Step out",             exec = require 'dap'.step_over,         keymap = { "n", "dk" } },
    { name = "Debug: Hover",                exec = Dap_better_hover,                keymap = { "n", "dK" } },
    { name = "Debug: Step into",            exec = require 'dap'.step_into,         keymap = { "n", "dl" } },
    { name = "Debug: Go to",                exec = dap_goto,                        keymap = { "n", "dL" } },
    { name = "Debug: Go up in callstack",   exec = require 'dap'.up,                keymap = { "n", "[s" } },
    { name = "Debug: Go down in callstack", exec = require 'dap'.down,              keymap = { "n", "]s" } },
    { name = "Debug: Show callstack",       exec = "Telescope dap frames",          keymap = { "n", "dS" } }, -- ds is "delete surrounding"
    -- { name = "Debug: Stop",              exec = require 'dap'.stop,              keymap = { "n", "ds" } },
    { name = "Debug: List breakpoints",     exec = dap_list_breapoints },
    -- { name = "Fold: Close all",             exec = require('ufo').closeAllFolds,    keymap = { "n", "zM" } },
    -- { name = "Fold: Open all",              exec = require('ufo').openAllFolds,     keymap = { "n", "zR" } },
    {
        name = "Diagnostics: Show for current file",
        exec = "Lspsaga show_buf_diagnostics",
    },
    {
        name = "Diagnostics: Show for workspace",
        exec = "Lspsaga show_workspace_diagnostics",
    },
    {
        name = "Fold: Open all",
        exec = "lua require('ufo').openAllFolds()",
        keymap = { "n", "zO" },

        -- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    },
    {
        name = "Fold: Close all",
        exec = "lua require('ufo').closeAllFolds()",
        keymap = { "n", "zM" },

        -- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
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
        keymap = { "n", "]g" }
    },
    {
        name = "Git: Previous hunk",
        exec = require 'gitsigns'.prev_hunk,
        keymap = { "n", "[g" }
    },
    -- {
    --     name = "Git: Preview hunk",
    --     exec = "Gitsigns preview_hunk",
    --     keymap = { "n", "<leader>gp" }
    -- },
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
        name = "Git: Show worktree changes",
        exec = "DiffviewOpen",
    },
    {
        name = "Git: Show current file changes",
        exec = "Gitsigns setloclist",
    },
    {
        -- TODO: Make this a regular gx with universal handlers
        name = "GitHub: Open link under cursor",
        exec = function()
            local current_word = vim.fn.expand('<cWORD>'):gsub('"', ''):gsub(',', '')
            local github_path = "https://github.com/" .. current_word
            vim.api.nvim_call_function("netrw#BrowseX", { github_path, 0 })
        end,
    },
    {
        name = "GitHub: Open link current repo",
        exec = function()
            local result = vim.system({ 'git', 'config', '--get', 'remote.origin.url' }, { text = true })
                :wait()
            if (result.code ~= 0) then
                print("Git exited with non-zero result")
            end
            local path = result.stdout:gsub("\n", "")
            vim.api.nvim_call_function("netrw#BrowseX", { path, 0 })
        end,
    },
    -- {
    --     name = "TreeSitter: Inspect tree",
    --     exec = vim.treesitter.inspect_tree,
    -- },
    -- {
    --     name = "TreeSitter: Edit query",
    --     exec = vim.treesitter.query.edit,
    -- },
    {
        name = "Zig: Build and run",
        exec = "wall | !zig build run",
        keymap = { "n", "<leader>zbr" },
        keymaps = {
            { "v", "<leader>zbr" }
        },
    },
    {
        name = "Zig: Build",
        exec = "!zig build",
        keymap = { "n", "<leader>zbb" },
        keymaps = {
            { "v", "<leader>zbb" }
        },
    },
    {
        name = "Quickfix: Show (toggle)",
        exec = toggle_quickfix,
        keymap = { "n", "gqq" },
    },
    {
        name = "Quickfix: Older",
        exec = "colder",
        keymap = { "n", "]Q" },
    },
    {
        name = "Quickfix: Newer",
        exec = "cnewer",
        keymap = { "n", "[Q" },
    },
    {
        name = "Quickfix: Clear",
        exec = function()
            vim.fn.setqflist({}, 'r')
        end,
    },
    {
        name = "Quickfix: Next",
        exec = "cnext",
        keymap = { "n", "]q" },
    },
    {
        name = "Quickfix: Previous",
        exec = "cprev",
        keymap = { "n", "[q" },
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
        -- keymap = { "n", "gfe" }, -- Makes go to fie (gf) slow
    },
    {
        name = "Test: Run nearest",
        exec = function()
            vim.cmd [[w]]
            require("neotest").run.run()
        end,
        keymap = { "n", "<leader>trr" }
    },
    {
        name = "Test: Debug",
        exec = function()
            vim.cmd [[w]]
            require("neotest").run.run({ strategy = "dap" })
        end,
        keymap = { "n", "<leader>td" }
    },
    {
        name = "Test: Run file",
        exec = function()
            vim.cmd [[w]]
            require("neotest").run.run(vim.fn.expand("%"))
        end,
        keymap = { "n", "<leader>trf" }
    },
    {
        name = "Test: Show full output",
        exec = "", --require 'neotest'.output.open,
        keymap = { "n", "<leader>to" }
    },
    {
        name = "Test: Show short output",
        exec = function() require 'neotest'.output.open({ short = true }) end,
        keymap = { "n", "<leader>tO" }
    },
    -- {
    --     name = "Increment selection",
    --     exec = require 'nvim-treesitter.incremental_selection'.node_incremental,
    --     -- todo: use something wiht v? or visual only, right?
    --     -- keymap = { "v", "<C-w>" },
    -- },
    -- {
    --     name = "Decrement selection",
    --     exec = require 'nvim-treesitter.incremental_selection'.node_decremental,
    --     -- keymap = { "v", "<C-S-w>" },
    -- },
    {
        name = "Search help",
        exec = "Telescope help_tags"
    },
    {
        name = "Telescope: Open last window",
        exec = "Telescope resume",
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
        name = "Tab: Close",
        exec = ":tabclose",
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
    {
        name = "SDL3: Open docs",
        exec = "!open https://wiki.libsdl.org/SDL3/CategoryAPI",
    },
    {
        name = "Zig: Open docs",
        exec = "!open https://ziglang.org/documentation/master/",
    },


    -- TODO: jump to next bookmark
    -- TODO: jump to previous bookmark
    -- TODO: explore bookmarks
    -- TODO: annotate bookmark?
    --require'bookmarks'.toggle_bookmarks()
}

local function set_keymap_for_string_command(keymap, string_command)
    vim.keymap.set(keymap[1], keymap[2], "<cmd>" .. string_command .. "<cr>")
end

local function set_keymap_for_function_command(keymap, function_command)
    vim.keymap.set(keymap[1], keymap[2], function_command)
end

local function set_keymaps()
    for _, command in ipairs(commands) do
        if type(command.exec) == "string" then
            if command.keymap ~= nil then
                set_keymap_for_string_command(command.keymap, command.exec)
            end
            if command.keymaps ~= nil then
                for index, keymap in ipairs(command.keymaps) do
                    set_keymap_for_string_command(keymap, command.exec)
                end
            end
        elseif type(command.exec) == "function" then
            if command.keymap ~= nil then
                set_keymap_for_function_command(command.keymap, command.exec)
            end
            if command.keymaps ~= nil then
                for index, keymap in ipairs(command.keymaps) do
                    set_keymap_for_function_command(keymap, command.exec)
                end
            end
        end
    end
end


set_keymaps()

local rpad = function(s, l, c)
    local res = s .. string.rep(c or ' ', l - #s)
    return res, res ~= s
end

local my_commands = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "my_commands",
        finder = finders.new_table {
            results = commands,
            entry_maker = function(entry)
                local name = entry.name
                if name and entry.keymap then
                    name = rpad(name, 50, ' ') .. "(" .. entry.keymap[2] .. ")"
                end
                return {
                    value = entry,
                    display = name,
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
