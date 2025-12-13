vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- ----------------------------------------------------------------
-- Options
-- ----------------------------------------------------------------

vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy" }
vim.opt.pumheight = 10
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true              -- Use spaces instead of tabs
vim.o.autoindent = true             -- Copy indent from previous line
vim.o.smartindent = true            -- Attempt to indent based on { and } pairs, etc.
vim.o.number = true                 -- Show line numbers
vim.o.mouse = 'a'                   -- Mouse for resizing window splits
vim.o.showmode = false              -- Don't show INSERT / VISUAL / etc.
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus' -- Use OS clipboard inside VIM
end)
vim.o.breakindent = true            -- Indent broken lines
vim.o.undofile = true               -- Save undo history
vim.o.undolevels = 10000            -- More undo levels
vim.o.ignorecase = true             -- Ignore case unless \C
vim.o.smartcase = true              -- Ignore case unless any capital letter
vim.o.signcolumn = 'yes'            -- Always draw sign column
vim.o.swapfile = false
vim.o.updatetime = 1000             -- Milliseconds of idle before swap write (and CursorHold)
vim.o.timeoutlen = 300              -- Milliseconds to wait for mapped sequence
vim.o.splitright = true             -- :vsplit puts new window on right
vim.o.splitbelow = true             -- :split puts new window below
vim.o.list = true                   -- Display whitespace
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    multispace = '·',
    nbsp = '␣',
}
vim.o.inccommand = 'split'  -- Preview substitutions live
vim.o.incsearch = true      -- Show results as you type
vim.o.cursorline = true     -- Show on which line the cursor is on
vim.o.scrolloff = 999       -- Keep cursor centered vertically
vim.o.confirm = true        -- Confirm to save on close if there are changes
vim.o.winborder = "rounded" -- Add border around floating windows
vim.o.conceallevel = 0      -- Don't hide stuff from me
vim.opt.grepprg = "rg --vimgrep --hidden --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

-- ----------------------------------------------------------------
-- Helper functions
-- ----------------------------------------------------------------

P = function(value)
    print(vim.inspect(value))
end

local rpad = function(s, l, c)
    local res = s .. string.rep(c or ' ', l - #s)
    return res, res ~= s
end

local feedkeys = function(keys)
    return function()
        vim.cmd([[:let key = nvim_replace_termcodes("]] .. keys .. [[", v:true, v:false, v:true)]])
        vim.cmd([[:call nvim_feedkeys(key, 'n', v:false)]])
    end
end

-- Redirect any command to buffer for better pager experience (like less).
vim.cmd [[com -nargs=1 -complete=command Redir :execute "tabnew | pu=execute(\'" . <q-args> . "\') | setl nomodified"]]
vim.cmd [[command -bar -nargs=* -complete=file -range=% -bang Write <line1>,<line2>write<bang> <args>]]

-- ----------------------------------------------------------------
-- Key mappings
-- ----------------------------------------------------------------
-- :helpgrep
-- <C-d>             Show available values, ex. :help cursor<C-d>
-- <C-a>             Insert all items (supports wildcards *.txt)
-- *                 Search current selection
-- q:                Command mode for entering commands like in a buffer.
-- q/                Search mode for entering search term like in a buffer.
-- =                 Auto indent visual selection
-- `[ `]             Start and end of pasted text
-- ``                Last location before bug jump
-- [{                Outer block bracket
-- iB aB             Inside/around block brackets
-- [(                Outer block paren
-- ib ab             Inside/around block parens
-- [%                Outer block match
-- i<C-r>.           Insert register of last insert
-- i<C-r>=           Insert expression (use system() for calling shell)
-- :TOhtml           Frikkin' WYSIWYG SSG
-- <C-w><S-hjkl>     Move windows
-- :vert h lua       Help on vertical split
-- ]q [q             Navigate quickfix list
-- ]l [l             Navigate loclist list
-- g; g,             Navigate changelist (:changes)
-- gn                Select search match
-- qQ                Append macro
-- :center           Center text
-- !!                Execute shell and insert
-- @:                Rerun last command

-- DEFAULT COMPLETION BINDINGS
-- <C-x><C-o>        Autocomplete
-- <C-x><C-f>        File path completion
-- <C-n> (<C-p>)     Autocomplete current buf
-- <C-n> and <C-p>   Next and previous
-- <C-y>             Accept current

-- :`<,`>norm        Repeat something on selection (<c-v> for esc, etc.)
-- cgn               Change search result (Repeat wiht .)
-- :read out.txt     Reads file into current cursor position
-- :w ++p            Create missing parent directories when saving
-- :cdo :cfdo        Run command on all items or files (end with | update to save)
-- :g/pattern        Search regex (jump with :123)
-- <C-r>"            Paste back what was changed in insert mode

vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>')                      -- Explore
vim.keymap.set("v", "<C-a>", "<C-a>gv")                               -- Increment numbers in visual mode without losing selection
vim.keymap.set("v", "y", "ygv<esc>")                                  -- Keep cursor in place after yank
vim.keymap.set("n", "YY", '"ayy:let @+ .= @a<CR>', { silent = true }) -- Yank appending to existing clipboard
vim.keymap.set("v", "Y", '"ay`>:let @+ .= @a<CR>', { silent = true }) -- Yank appending to existing clipboard
vim.keymap.set("n", "Q", "<nop>")                                     -- Disable ex mode
vim.keymap.set("n", "J", "gJ")                                        -- Join lines without spaces in between
vim.keymap.set("n", "<CR>", "i<CR><ESC>")                             -- Break line in normal mode
vim.keymap.set("v", "<", "<gv")                                       -- Indent left without losing visual selection
vim.keymap.set("v", ">", ">gv")                                       -- Indent right without losing visual selection
vim.keymap.set("n", "<C-a>", "gg^vG$")                                -- Select all text
vim.keymap.set("v", "<C-a>", "<C-a>gv")                               -- Increment numbers in visual mode without losing selection
vim.keymap.set("v", "*", '"tyq/"tp<CR>')                              -- Search selection

-- Marks
vim.keymap.set("n", "<leader>k1", "mQ")
vim.keymap.set("n", "<leader>k2", "mW")
vim.keymap.set("n", "<leader>k3", "mE")
vim.keymap.set("n", "<leader>k4", "mR")
vim.keymap.set("n", "<leader>k5", "mT")
vim.keymap.set("n", "<leader>k6", "mY")
vim.keymap.set("n", "<leader>k7", "mU")
vim.keymap.set("n", "<leader>k8", "mI")
vim.keymap.set("n", "<leader>k9", "mO")
vim.keymap.set("n", "<leader>k0", "mP")
vim.keymap.set("n", "<leader>ką", "mQ")
vim.keymap.set("n", "<leader>kč", "mW")
vim.keymap.set("n", "<leader>kę", "mE")
vim.keymap.set("n", "<leader>kė", "mR")
vim.keymap.set("n", "<leader>kį", "mT")
vim.keymap.set("n", "<leader>kš", "mY")
vim.keymap.set("n", "<leader>kų", "mU")
vim.keymap.set("n", "<leader>kj", "mI")
vim.keymap.set("n", "<leader>1", "mz'Q'z")
vim.keymap.set("n", "<leader>2", "mz'W'z")
vim.keymap.set("n", "<leader>3", "mz'E'z")
vim.keymap.set("n", "<leader>4", "mz'R'z")
vim.keymap.set("n", "<leader>5", "mz'T'z")
vim.keymap.set("n", "<leader>6", "mz'Y'z")
vim.keymap.set("n", "<leader>7", "mz'U'z")
vim.keymap.set("n", "<leader>8", "mz'I'z")
vim.keymap.set("n", "<leader>9", "mz'O'z")
vim.keymap.set("n", "<leader>0", "mz'P'z")
vim.keymap.set("n", "<leader>ą", "mz'Q'z")
vim.keymap.set("n", "<leader>č", "mz'W'z")
vim.keymap.set("n", "<leader>ę", "mz'E'z")
vim.keymap.set("n", "<leader>ė", "mz'R'z")
vim.keymap.set("n", "<leader>į", "mz'T'z")
vim.keymap.set("n", "<leader>š", "mz'Y'z")
vim.keymap.set("n", "<leader>ų", "mz'U'z")
vim.keymap.set("n", "<leader>ū", "mz'I'z")

vim.keymap.set("i", "<C-Space>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })

-- Quickfix buffer
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.keymap.set("n", "<CR>", "<CR><C-w>p", { remap = true, buffer = true }) -- Jump to item under cursor
    end
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.cmd(":hi statusline guibg=none")
vim.cmd(":hi statusline guibg=none")
vim.cmd(":hi normal guibg=black")

-- ----------------------------------------------------------------
-- Plugins
-- ----------------------------------------------------------------
vim.pack.add({
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- { src = 'https://github.com/GustavEikaas/easy-dotnet.nvim' },                            -- Wouldn't be dotnet if it just worked without additional plugins
    { src = 'https://github.com/JanikkinaJ/lazydev.nvim',             version = "ca311b8" }, -- https://github.com/folke/lazydev.nvim/issues/114
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', branch = 'master' }
})

require('lazydev').setup()
require('nvim-treesitter.configs').setup(
    {
        modules = {},
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "zig" },
        sync_install = false,
        auto_install = true,
        ignore_install = { "javascript" },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
    }
)

-- ----------------------------------------------------------------
-- Mini.pick
-- ----------------------------------------------------------------
local pick = require('mini.pick')
pick.setup({
    mappings = {
        choose_marked = '<C-q>'
    }
})
-- Temporarily change rg config for a single action
local with_rg_config = function(config_name, action)
    local rg_env = 'RIPGREP_CONFIG_PATH'
    local prev_config = vim.uv.os_getenv(rg_env) or ''
    vim.uv.os_setenv(rg_env, '/Users/llaz/git/dotfiles/rg/' .. config_name)
    action()
    vim.uv.os_setenv(rg_env, prev_config)
end
pick.registry.hidden_files = function()
    with_rg_config('hidden', function()
        pick.builtin.files({ tool = 'rg' })
    end)
end

require('oil').setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'oil',
    callback = function()
        -- Execute command on target entry
        vim.keymap.set('n', '!', function()
            require 'oil.actions'.open_cmdline.callback()
        end, { remap = true, buffer = true })
        vim.keymap.set('n', '<TAB>', function()
            require 'oil.actions'.preview.callback()
        end, { remap = true, buffer = true })

        -- Yank absolute path to clipboard register.
        vim.keymap.set('n', 'gy', function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
                return
            end
            local path = dir .. entry.name
            vim.fn.setreg(vim.v.register, path)
            print("Copied path")
        end, { remap = true, buffer = true })

        -- Append absolute path to clibpoard register.
        -- Use `gp` or `gm` to paste or move respectively.
        vim.keymap.set('n', 'gY', function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            if not entry or not dir then
                return
            end
            local path = dir .. entry.name
            local prev_clipboard = vim.fn.getreg(vim.v.register)
            prev_clipboard = prev_clipboard .. "\n" .. path
            vim.fn.setreg(vim.v.register, prev_clipboard)
            print('Copied path (append)')
        end, { remap = true, buffer = true })

        -- Paste files from absolute paths.
        vim.keymap.set('n', 'gp',
            function()
                local oil = require 'oil'
                if vim.bo.modified then
                    local ok, choice = pcall(vim.fn.confirm, "Discard changes?", "No\nYes")
                    if not ok or choice ~= 2 then
                        return
                    end
                end
                local source_paths = {}
                for path in vim.fn.getreg('+'):gmatch('[^\n%s]+') do
                    source_paths[#source_paths + 1] = path
                    print(path)
                end
                local target = oil.get_cursor_entry()
                local current_dir = oil.get_current_dir()
                if not target or not current_dir then
                    return
                end
                local target_path = current_dir .. target.name
                local is_target_a_dir = target.type == "directory"
                if is_target_a_dir then
                    -- Use target_path, which points to some dir
                else
                    -- Target is a file, get parent dir
                    target_path = vim.fn.fnamemodify(target_path, ":h")
                    if (vim.fn.filereadable(target_path)) then
                        -- File already exists, give a different name
                        target_path = vim.fn.input("Target path: ", target_path, "file")
                    end
                end
                for _, source_path in ipairs(source_paths) do
                    vim.fn.system { 'cp', '-R', source_path, target_path }
                end
                vim.cmd.edit({ bang = true })
                vim.cmd.nohlsearch()
                print('Pasted ' .. #source_paths .. ' items')
            end,
            { remap = true, buffer = true })

        -- Move files from absolute paths
        vim.keymap.set('n', 'gm',
            function()
                local oil = require 'oil'
                if vim.bo.modified then
                    local ok, choice = pcall(vim.fn.confirm, "Discard changes?", "No\nYes")
                    if not ok or choice ~= 2 then
                        return
                    end
                end
                local source_paths = {}
                for path in vim.fn.getreg('+'):gmatch('[^\n%s]+') do
                    source_paths[#source_paths + 1] = path
                end
                local target = oil.get_cursor_entry()
                local current_dir = oil.get_current_dir()
                if not target or not current_dir then
                    return
                end
                local target_path = current_dir .. target.name
                local is_target_a_dir = target.type == "directory"
                if is_target_a_dir then
                    -- Use target_path, which points to some dir
                else
                    -- Target is a file, get parent dir
                    target_path = vim.fn.fnamemodify(target_path, ":h")
                    if (vim.fn.filereadable(target_path)) then
                        -- File already exists, give a different name
                        target_path = vim.fn.input("Target path: ", target_path, "file")
                    end
                end
                for _, source_path in ipairs(source_paths) do
                    vim.fn.system { 'mv', source_path, target_path }
                end
                vim.cmd.edit({ bang = true })
                vim.cmd.nohlsearch()
                require("oil.actions").refresh.callback()
                print('Moved ' .. #source_paths .. ' items')
            end,
            { remap = true, buffer = true })
    end
})

local gitsigns = require('gitsigns')
gitsigns.setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
})


-- ----------------------------------------------------------------
-- Markdown
-- ----------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.keymap.set("n", "gf", function()
            local word = vim.fn.expand("<cWORD>")
            local label, path = word:match("%[([^%]]+)%]%(([^%)]+)%)") -- Matches markdown link format [label](path)
            _ = label
            if path then
                if path:match("^file://") then
                    path = path:gsub("^file://", "")
                    local line = path:match("#L(%d+)$")
                    path = path:gsub("#L%d+$", "")

                    if line then
                        vim.cmd("tabedit +" .. line .. " " .. vim.fn.fnameescape(path))
                    else
                        vim.cmd("tabedit " .. path)
                    end
                else
                    vim.cmd.normal({ "gf", bang = true }) -- Fallback to normal gf
                end
            else
                vim.cmd.normal({ "gf", bang = true }) -- Fallback to normal gf
            end
        end, { noremap = true, silent = true })
    end
})

-- ----------------------------------------------------------------
-- LSP
-- ----------------------------------------------------------------
vim.lsp.config('roslyn_ls', {
    cmd = {
        "/usr/local/share/dotnet/dotnet",
        "/Users/llaz/dotnet-sdk/Microsoft.CodeAnalysis.LanguageServer.dll",
        "--logLevel",
        "Information",
        "--extensionLogDirectory",
        "/Users/llaz/temp/roslyn_ls/logs",
        "--stdio",
    }
})

vim.lsp.enable({ 'lua_ls', 'zls', 'roslyn_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('MyLspAttach', {}),
    callback = function(event)
        -- Format on save
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('MyAutoFormat', {}),
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
})

-- ----------------------------------------------------------------
-- Diagnostics
-- ----------------------------------------------------------------
vim.diagnostic.config {
    virtual_lines = false,
    severity_sort = true,
    float = { source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
        source = 'if_many',
        spacing = 3,
    },
}

-- ----------------------------------------------------------------
-- My Commands
-- ----------------------------------------------------------------
local execute_command = function(command)
    if type(command.exec) == "string" then
        if (command.silent) then
            vim.cmd("silent " .. command.exec)
        else
            vim.cmd(command.exec)
        end
    elseif type(command.exec) == "function" then
        command.exec()
    end
end

local add_command_keymap = function(command)
    if command.keymap ~= nil then
        local mode = command.keymap[1]
        local keys = command.keymap[2]
        vim.keymap.set(mode, keys, function() execute_command(command) end, { silent = command.silent or false })
    end
    if command.keymaps ~= nil then
        for _, keymap in pairs(command.keymaps) do
            local mode = keymap[1]
            local keys = keymap[2]
            vim.keymap.set(mode, keys, function() execute_command(command) end,
                { silent = command.silent or false })
        end
    end
end

local create_commands = function(commands)
    for _, command in pairs(commands) do
        add_command_keymap(command)
        command.text = command.name
        if command.name and command.keymap then
            command.text = rpad(command.name, 50, ' ') .. "(" .. command.keymap[2] .. ")"
        end
    end
    return commands
end

local commands = create_commands({

    { name = "Config: Relaod",       exec = 'execute "source " . stdpath("config") . "/init.lua"' },


    { name = "Build: Make",          exec = ":make", },

    { name = "Edit: Wrap Text",      exec = feedkeys("gw"),                                       keymap = { "v", "gw" }, },
    -- Note 'gq' triggers LSP if it's attached.

    { name = "Config: Source",       exec = "exe 'source' stdpath('config') .. '/init.lua'" },

    { name = "LSP: Rename",          exec = vim.lsp.buf.rename,                                   keymap = { "n", "grn" }, silent = true },
    { name = "LSP: Code Action",     exec = vim.lsp.buf.code_action,                              keymap = { "n", "gra" }, silent = true },
    { name = "LSP: References",      exec = vim.lsp.buf.references,                               keymap = { "n", "grr" }, silent = true },
    { name = "LSP: Implementation",  exec = vim.lsp.buf.implementation,                           keymap = { "n", "gri" }, silent = true },
    { name = "LSP: Type Definition", exec = vim.lsp.buf.type_definition,                          keymap = { "n", "grt" }, silent = true },
    { name = "LSP: Hover",           exec = vim.lsp.buf.hover,                                    keymap = { "n", "K" },   silent = true },
    { name = "LSP: Document Symbol", exec = vim.lsp.buf.document_symbol,                          keymap = { "n", "gO" },  silent = true },
    {
        name = "LSP: Restart",
        exec = function()
            vim.cmd [[:lua vim.lsp.stop_client(vim.lsp.get_clients())]]
            vim.cmd [[:edit]]
        end,
        silent = true
    },
    {
        name = "LSP: Current settings",
        exec = "Redir lua P(vim.lsp.get_active_clients())"
    },
    -- "LSP: Definition" by default is <C-]> and <C-W>]

    { name = "Keymap: Show current",       exec = [[Redir silent map]], },

    { name = "Diagnostic: Open Float",     exec = vim.diagnostic.open_float, keymap = { "n", "<C-w>d" }, silent = true },
    { name = "Diagnostic: Go to Next",     exec = vim.diagnostic.goto_next,  keymap = { "n", "]e" },     silent = true },
    { name = "Diagnostic: Go to Previous", exec = vim.diagnostic.goto_prev,  keymap = { "n", "[e" },     silent = true },

    { name = "Fold: Toggle",               exec = feedkeys("za"),            keymap = { "n", "za" },     silent = true },
    { name = "Fold: Paragraph",            exec = feedkeys("zfip"),          keymap = { "n", "zfip" },   silent = true },
    { name = "Fold: Match",                exec = feedkeys("zf%"),           keymap = { "n", "zf%" },    silent = true },

    { name = "Quickfix: Open",             exec = "copen",                   silent = true },
    { name = "Quickfix: Older",            exec = "colder",                  keymap = { "n", "]Q" }, },
    { name = "Quickfix: Newer",            exec = "cnewer",                  keymap = { "n", "[Q" }, },
    {
        name = "Quickfix: Clear",
        exec = function() vim.fn.setqflist({}, 'r') end,
    },
    { name = "Quickfix: Filter",                 exec = feedkeys(":Cfilter "), },
    {
        name = "Quickfix: Copy file paths",
        exec = function()
            vim.cmd [[call setreg('+', [])]]
            vim.cmd [[cdo let @+ .= expand('%:p') . "\n"]]
        end
    },

    {
        name = "Explorer: Send to quickfix",
        exec = function()
            require('oil.actions').send_to_qflist.callback({
                action = "a",
                only_matching_search = true,
                target = "qflist",
            });
        end
    },

    { name = "Make: Run",                        exec = "make",                               silent = true },

    { name = "File: Info",                       exec = feedkeys("g<C-g>"),                   keymap = { "n", "g<C-g>" },     silent = true },
    { name = "File: Find",                       exec = pick.registry.hidden_files,           keymap = { "n", "<leader>ff" }, silent = true },
    { name = "File: Recent",                     exec = pick.builtin.buffers,                 keymap = { "n", "<leader>fr" }, silent = true },
    { name = "File: Grep",                       exec = pick.builtin.grep_live,               keymap = { "n", "<leader>fg" }, silent = true },
    { name = "File: Show unsaved changes",       exec = ":w !diff % -", },
    { name = "File: Type",                       exec = ":set filetype?", },
    { name = "File: Copy absolute path",         exec = [[:!echo %:p | tr -d '\n' | pbcopy]], silent = true },
    { name = "File: Reload & Discard Changes",   exec = feedkeys("e!") },

    { name = "Tab: Close all except current",    exec = ":tabonly" },

    { name = "Window: Close all except current", exec = ":only" },

    {
        name = "Terminal: Run with output",
        exec = function()
            vim.ui.input({}, function(c)
                if c and c ~= "" then
                    vim.cmd("noswapfile vnew")
                    vim.bo.buftype = "nofile"
                    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
                end
            end)
        end
        ,
        keymap = { "n", "<leader>c" },
        silent = true
    },

    { name = "Char: ASCII",         exec = feedkeys("ga"),                    keymap = { "n", "ga" },        silent = true },
    { name = "Char: Hex",           exec = feedkeys("g8"),                    keymap = { "n", "g8" },        silent = true },

    { name = "Git: Blame",          exec = gitsigns.blame_line,               keymap = { "n", "<leader>gb" } },
    { name = "Git: Diff this",      exec = gitsigns.diffthis, },
    { name = "Git: Toggle blame",   exec = gitsigns.toggle_current_line_blame },
    { name = "Git: Toggle deleted", exec = gitsigns.preview_hunk_inline },
    { name = "Git: Next hunk",      exec = gitsigns.next_hunk,                keymap = { "n", "]g" } },
    { name = "Git: Previous hunk",  exec = gitsigns.prev_hunk,                keymap = { "n", "[g" } },
    { name = "Git: Reset hunk",     exec = gitsigns.reset_hunk, },
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

    { name = "SDL3: Open docs",          exec = "!open https://wiki.libsdl.org/SDL3/CategoryAPI", },
    { name = "Zig: Open docs",           exec = "!open https://ziglang.org/documentation/master/", },

    { name = "TreeSitter: Inspect tree", exec = vim.treesitter.inspect_tree, },
    { name = "TreeSitter: Edit query",   exec = vim.treesitter.query.edit, },
})

vim.keymap.set({ 'n', 'v' }, '<leader>:', function()
    local selected = pick.start({
        source = {
            name = 'Commands',
            items = commands,
            choose = function(selected)
                -- Empty choose function to avoid printing.
            end
        }
    })
    if (selected) then
        execute_command(selected)
    end
end, { silent = true });

-- ----------------------------------------------------------------
-- Snippets
-- ----------------------------------------------------------------
-- Triggered by <C-]> after inserting trigger phrase.

---Refer to <https://microsoft.github.io/language-server-protocol/specification/#snippet_syntax>
---for the specification of valid body.
function vim.snippet.add(trigger, body, opts)
    vim.keymap.set("ia", trigger, function()
        -- If abbrev is expanded with keys like "(", ")", "<cr>", "<space>",
        -- don't expand the snippet. Only accept "<c-]>" as a trigger key.
        local c = vim.fn.nr2char(vim.fn.getchar(0))
        if c ~= "" then
            vim.api.nvim_feedkeys(trigger .. c, "i", true)
            return
        end
        vim.snippet.expand(body)
    end, opts)
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function()
        vim.snippet.add(
            "fn",
            "function ${1:name}($2)\n\t${3:-- content}\nend",
            { buffer = 0 }
        )
    end
})

-- ----------------------------------------------------------------
-- Status line
-- ----------------------------------------------------------------

---Show attached LSP clients in `[name1, name2]` format.
---Long server names will be modified. For example, `lua-language-server` will be shorten to `lua-ls`
---Returns an empty string if there aren't any attached LSP clients.
---@return string
local function lsp_status()
    local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #attached_clients == 0 then
        return ""
    end
    local names = vim.iter(attached_clients)
        :map(function(client)
            local name = client.name:gsub("language.server", "ls")
            return name
        end)
        :totable()
    return "[" .. table.concat(names, ", ") .. "]"
end

function _G.statusline()
    return table.concat({
        "%f",
        "%h%w%m%r",
        "%=",
        lsp_status(),
        " %-14(%l,%c%V%)",
        "%P",
    }, " ")
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
