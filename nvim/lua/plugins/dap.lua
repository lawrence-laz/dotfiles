-- TODO:
-- // My commands?
--
-- dp       - pause
-- drt      - test
--
-- [ ] Jump to where the cursor currently is stopped
--
-- [ ] Attach debugger      attach()
-- [ ] Clear breakpoints
-- [ ] Virtual text?
-- [ ] Callstack (threads?)
--      [ ] up/down() callstack
-- [ ] Repl     repl.open({}, 'vsplit')
--      [ ] Repl cmp
--      [ ] Repl highlight
-- [ ] neotest
-- [ ] 'telescope'.setup()      'telescope'.load_extension('dap')
--      [ ] Telescope frames, Telescope list_breakpoints

-- This is a copy/paste from dap repo, because I need for the function below.
local function dap_eval_expression(expr)
    local mode = vim.api.nvim_get_mode()
    if mode.mode == 'v' then
        -- [bufnum, lnum, col, off]; 1-indexed
        local start = vim.fn.getpos('v')
        local end_ = vim.fn.getpos('.')

        local start_row = start[2]
        local start_col = start[3]

        local end_row = end_[2]
        local end_col = end_[3]

        if start_row == end_row and end_col < start_col then
            end_col, start_col = start_col, end_col
        elseif end_row < start_row then
            start_row, end_row = end_row, start_row
            start_col, end_col = end_col, start_col
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'n', false)

        -- buf_get_text is 0-indexed; end-col is exclusive
        local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
        return table.concat(lines, '\n')
    end
    expr = expr or '<cexpr>'
    if type(expr) == "function" then
        return expr()
    elseif type(expr) == "string" then
        return vim.fn.expand(expr)
    end
end

-- TODO: Eager load?

-- This is a custom function to support LSP like hovering where the first invocation only shows the window, but does not jump to it,
-- and the second invocation makes it jump inside the floating window.
-- (It's not very nice, because I had to copy some internal functions to make this work, related issue https://github.com/mfussenegger/nvim-dap/issues/1194
function Dap_better_hover(expr, winopts)
    local value = dap_eval_expression(expr)

    local bufnr, winid = vim.lsp.util.open_floating_preview({}, "dap-float", {
        focusable = true,
        close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
        focus_id = 'dappp',
        focus = true,
        width = 100,
        height = 5,
    })

    local buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 1, 999, false)
    if (#buffer_lines ~= 0) then
        -- If buffer already existed, then we just jumped into it and can return early to avoid creating duplicated content.
        return
    end

    -- Buffer options
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].filetype = "dap-float"
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].buftype = "nofile"
    vim.api.nvim_buf_set_name(bufnr, 'dap-hover-' .. tostring(bufnr) .. ': ' .. value)

    -- Window options
    vim.wo[winid].scrolloff = 0

    -- Key mappings for the buffer
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", "<Cmd>lua require('dap.ui').trigger_actions({ mode = 'first' })<CR>",
        {})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "a", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "o", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<2-LeftMouse>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})

    local view = require("dap.ui.widgets").builder(require("dap.ui.widgets").expression)
        .new_buf(function() return bufnr end)
        .new_win(require("dap.ui.widgets").with_resize(function() return winid end))
        .build()
    view.open(value)
    return view
end

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function(_, opts)
            local dap = require("dap")
            dap.configurations.zig = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ",
                            vim.fn.glob(vim.fn.getcwd() .. "/zig-out/bin/"), "file")
                    end,
                    args = { "zig" },
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    initCommands = { "command source ~/.lldbinit" },
                },
            }

            local liblldb_path = require("mason-registry").get_package("codelldb"):get_install_path()
                .. "/extension/lldb/lib/liblldb.so" -- Linux
            -- .. "/extension/lldb/lib/liblldb.dylib" -- MacOS

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--liblldb", liblldb_path, "--port", "${port}" },
                    -- On windows you may have to uncomment this:
                    -- detached = false,
                },
            }

            -- .NET C#
            dap.adapters.coreclr = {
                type = 'executable',
                command = '/home/llaz/bin/netcoredbg/netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }

            vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
            vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
            vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
            vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })
            vim.api.nvim_set_hl(0, "red", { fg = "#f38ba8" })

            vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '⨀', texthl = 'DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '⊘', texthl = 'DapBreakpoint' })
            vim.fn.sign_define('DapStopped', { text = '→', texthl = 'yellow', })
            vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'yellow' })
        end
    },
}
