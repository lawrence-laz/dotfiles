local os = vim.loop.os_uname().sysname
local is_windows = os == "Windows_NT"
local is_darwin = os == "Darwin"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

if vim.g.neovide == true then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_scroll_animation_length = 0.10
    vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end

-- ----------------------------------------------------------------
-- Options
-- ----------------------------------------------------------------

-- vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy" }
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy", "preview" }
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
vim.g.backup = false
vim.g.writebackup = false

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

local path_join = function(a, b)
    return a:gsub('/$', '') .. '/' .. b
end

local exists = function(path)
    return vim.loop.fs_stat(path) ~= nil
end

local function move_merge(src, dst, overwrite)
    local stat = vim.loop.fs_stat(src)
    if not stat then return end

    if stat.type == "file" then
        if exists(dst) and overwrite then
            vim.loop.fs_unlink(dst)
        end
        vim.loop.fs_rename(src, dst)
    elseif stat.type == "directory" then
        if not exists(dst) then
            vim.loop.fs_mkdir(dst, 493) -- 0755
        end

        local handle = vim.loop.fs_scandir(src)
        if handle then
            while true do
                local name = vim.loop.fs_scandir_next(handle)
                if not name then break end
                move_merge(path_join(src, name), path_join(dst, name), overwrite)
            end
        end
        -- remove empty src dir after merging
        vim.loop.fs_rmdir(src)
    end
end

local function mvout(dir)
    local stat = vim.loop.fs_stat(dir)
    if not stat or stat.type ~= "directory" then
        vim.notify("Not a directory: " .. dir, vim.log.levels.ERROR)
        return
    end

    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
        vim.notify("Cannot move contents of root directory", vim.log.levels.ERROR)
        return
    end

    local handle = vim.loop.fs_scandir(dir)
    if not handle then
        vim.notify("Failed to read directory: " .. dir, vim.log.levels.ERROR)
        return
    end

    local items = {}
    while true do
        local name = vim.loop.fs_scandir_next(handle)
        if not name then break end
        table.insert(items, name)
    end

    if #items == 0 then
        vim.loop.fs_rmdir(dir)
        vim.notify("Directory was empty, removed")
        return
    end

    -- detect conflicts
    local conflicts = {}
    for _, name in ipairs(items) do
        if exists(path_join(parent, name)) then
            table.insert(conflicts, name)
        end
    end

    local overwrite = false
    if #conflicts > 0 then
        local msg = "Overwrite existing items?\n\n" .. table.concat(conflicts, "\n")
        local choice = vim.fn.confirm(msg, "&Yes\n&No\n&Cancel", 3)

        if choice == 3 then
            vim.notify("Cancelled")
            return
        elseif choice == 1 then
            overwrite = true
        end
        -- choice == 2 → skip conflicts, overwrite = false
    end

    -- move items
    for _, name in ipairs(items) do
        local src = path_join(dir, name)
        local dst = path_join(parent, name)

        if exists(dst) and not overwrite then
            goto continue
        end

        move_merge(src, dst, overwrite)
        ::continue::
    end

    -- remove the now-empty source directory
    vim.loop.fs_rmdir(dir)
    vim.notify("Moved contents up and removed directory")
end

local extract_zip = function(zip_path)
    local stat = vim.loop.fs_stat(zip_path)
    if not stat or stat.type ~= "file" then
        vim.notify("Not a file: " .. zip_path, vim.log.levels.ERROR)
        return
    end

    if not zip_path:lower():match("%.zip$") then
        vim.notify("Not a zip file", vim.log.levels.ERROR)
        return
    end

    local parent = vim.fn.fnamemodify(zip_path, ":h")
    local base = vim.fn.fnamemodify(zip_path, ":t:r")
    local dest = path_join(parent, base)

    if not exists(dest) then
        vim.loop.fs_mkdir(dest, 493) -- 0755
    end

    local sys = vim.loop.os_uname().sysname

    if sys == "Darwin" then
        local handle
        handle = vim.loop.spawn(
            "unzip",
            {
                args = { "-o", zip_path, "-d", dest },
                stdio = { nil, nil, nil },
            },
            function(code)
                if handle then handle:close() end
                vim.schedule(function()
                    if code == 0 then
                        vim.notify("Extracted to " .. dest)
                    else
                        vim.notify("Zip extraction failed", vim.log.levels.ERROR)
                    end
                end)
            end
        )

        if not handle then
            vim.notify("Failed to start unzip", vim.log.levels.ERROR)
        end
    elseif sys == "Windows_NT" then
        vim.notify(
            "Zip extraction not implemented on Windows yet",
            vim.log.levels.WARN
        )
    else
        vim.notify("Unsupported OS for zip extraction", vim.log.levels.ERROR)
    end
end

local lowercase_cabbrev = function(cmd)
    local lower = cmd:lower()

    vim.cmd(string.format([[
        cnoreabbrev <expr> %s getcmdtype() == ":" && getcmdline() == "%s" ? "%s" : "%s"
    ]], lower, lower, cmd, lower))
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

vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")

-- Paste for non terminal environments
vim.keymap.set(
    { 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' },
    '<C-S-v>',
    function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
    { noremap = true, silent = true }
)

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
    { src = 'https://github.com/echasnovski/mini.extra' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/JanikkinaJ/lazydev.nvim',             version = "ca311b8" }, -- https://github.com/folke/lazydev.nvim/issues/114
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', branch = 'master' },
    { src = 'https://github.com/ThePrimeagen/harpoon' },
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
require("harpoon").setup()
for i = 1, 9 do
    vim.keymap.set("n", "<leader>k" .. i, function() require("harpoon.mark").set_current_at(i) end)
    vim.keymap.set("n", "<leader>" .. i, function() require("harpoon.ui").nav_file(i) end)
end

-- ----------------------------------------------------------------
-- Mini.pick
-- ----------------------------------------------------------------
local pick = require('mini.pick')
pick.setup({
    mappings = {
        choose_marked = '<C-q>',
        -- Default:
        -- <C-o>      glob pattern
        -- <C-Space>  pick again from current results
        -- <C-a>      select all
    },
})
require('mini.extra').setup({})
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
        local copy_oil_paths = function(opts)
            local oil = require("oil")
            local dir = oil.get_current_dir()
            if not dir then return end

            local append = opts and opts.append
            local visual = opts and opts.visual

            local paths = {}

            local bufnr = vim.api.nvim_get_current_buf()

            if visual then
                -- Exit visual mode so marks get updated (why nvim, why?)
                vim.cmd([[ execute "normal! \<ESC>" ]])
                local mode = vim.fn.visualmode()
                local start_pos = vim.fn.getpos("'<")
                local end_pos = vim.fn.getpos("'>")
                local start_line = start_pos[2]
                local end_line = end_pos[2]

                if start_line > end_line then
                    start_line, end_line = end_line, start_line
                end

                for lnum = start_line, end_line do
                    local entry = oil.get_entry_on_line(bufnr, lnum)
                    if entry then
                        table.insert(paths, dir .. entry.name)
                    end
                end
            else
                local entry = oil.get_cursor_entry()
                if not entry then return end
                table.insert(paths, dir .. entry.name)
            end

            if #paths == 0 then return end

            local text = table.concat(paths, "\n")

            if append then
                local prev = vim.fn.getreg(vim.v.register)
                if prev ~= "" then
                    text = prev .. "\n" .. text
                end
            end

            vim.fn.setreg(vim.v.register, text)
            vim.notify("Copied " .. #paths .. " path(s)" .. (append and " (append)" or ""))
        end

        -- Execute command on target entry
        vim.keymap.set('n', '!', function()
            require 'oil.actions'.open_cmdline.callback()
        end, { remap = true, buffer = true })
        vim.keymap.set('n', '<TAB>', function()
            require 'oil.actions'.preview.callback()
        end, { remap = true, buffer = true })

        -- Yank absolute path(s) to clipboard register.
        -- Use `gp` or `gm` to paste or move respectively.
        vim.keymap.set("n", "gy", function()
            copy_oil_paths({ append = false, visual = false })
        end, { remap = true, buffer = true })
        vim.keymap.set("v", "gy", function()
            copy_oil_paths({ append = false, visual = true })
        end, { remap = true, buffer = true })

        -- Append absolute path(s) to clibpoard register.
        -- Use `gp` or `gm` to paste or move respectively.
        vim.keymap.set("n", "gY", function()
            copy_oil_paths({ append = true, visual = false })
        end, { remap = true, buffer = true })
        vim.keymap.set("v", "gY", function()
            copy_oil_paths({ append = true, visual = true })
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

        -- Move files from absolute path
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

        -- Move out files from directory under cursor and delete the dir
        vim.api.nvim_create_user_command("MvOut", function()
            local oil = require("oil")

            local entry = oil.get_cursor_entry()
            local cwd = oil.get_current_dir()

            if not entry or not cwd then
                vim.notify("No entry under cursor", vim.log.levels.ERROR)
                return
            end

            if entry.type ~= "directory" then
                vim.notify("Entry is not a directory", vim.log.levels.ERROR)
                return
            end

            local dir = cwd:gsub('/$', '') .. '/' .. entry.name
            mvout(dir)
            vim.cmd("e!") -- Refresh buffer
        end, {})
        lowercase_cabbrev("MvOut")

        -- Extract archive file under cursor into new directory under same name
        vim.api.nvim_create_user_command("Extract", function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local cwd = oil.get_current_dir()

            if not entry or not cwd or entry.type ~= "file" then
                vim.notify("Cursor is not on a zip file", vim.log.levels.ERROR)
                return
            end

            extract_zip(path_join(cwd, entry.name))
            vim.cmd("e!")
        end, {})
        lowercase_cabbrev("Extract")
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


local function resolve_glob(pat)
    local uv = vim.uv or vim.loop
    pat = pat:gsub("\\", "/")

    local matches = vim.fn.glob(pat, true, true)
    if type(matches) == "string" then
        matches = { matches }
    end

    if #matches == 0 then
        error("resolve_glob: no match for: " .. pat)
    elseif #matches > 1 then
        error("resolve_glob: more than one match for: " .. pat .. "\n" .. table.concat(matches, "\n"))
    end

    local st = uv.fs_stat(matches[1])
    if not (st and st.type == "file") then
        error("resolve_glob: match is not a file: " .. matches[1])
    end
    return matches[1]
end

if is_darwin then
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
elseif is_windows then
    vim.lsp.config('roslyn_ls', {
        cmd = { 'C:/Program Files/dotnet/dotnet.exe',
            resolve_glob(
                'C:/Users/laurynas.lazauskas/.vscode/extensions/ms-dotnettools.csharp-*/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll'),
            '--logLevel',
            'Information', '--extensionLogDirectory', vim.fs.joinpath(vim.uv.os_tmpdir(), 'roslyn_ls/logs'), '--stdio' }
    })
end

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

    { name = "Config: Relaod",         exec = 'execute "source " . stdpath("config") . "/init.lua"' },


    { name = "Build: Make",            exec = ":make", },

    { name = "Buffer: Delete (Close)", exec = ":bd" },

    { name = "Edit: Wrap Text",        exec = feedkeys("gw"),                                       keymap = { "v", "gw" }, },
    -- Note 'gq' triggers LSP if it's attached.

    { name = "Config: Source",         exec = "exe 'source' stdpath('config') .. '/init.lua'" },

    { name = "LSP: Rename",            exec = vim.lsp.buf.rename,                                   keymap = { "n", "grn" }, silent = true },
    { name = "LSP: Code Action",       exec = vim.lsp.buf.code_action,                              keymap = { "n", "gra" }, silent = true },
    { name = "LSP: References",        exec = vim.lsp.buf.references,                               keymap = { "n", "grr" }, silent = true },
    { name = "LSP: Implementation",    exec = vim.lsp.buf.implementation,                           keymap = { "n", "gri" }, silent = true },
    { name = "LSP: Type Definition",   exec = vim.lsp.buf.type_definition,                          keymap = { "n", "grt" }, silent = true },
    { name = "LSP: Hover",             exec = vim.lsp.buf.hover,                                    keymap = { "n", "K" },   silent = true },
    { name = "LSP: Document Symbol",   exec = vim.lsp.buf.document_symbol,                          keymap = { "n", "gO" },  silent = true },
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
    { name = "Quickfix: Filter",               exec = feedkeys(":Cfilter "), },
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

    { name = "Make: Run",                      exec = "make",                                                               silent = true },

    { name = "File: Info",                     exec = feedkeys("g<C-g>"),                                                   keymap = { "n", "g<C-g>" },     silent = true },
    { name = "File: Find",                     exec = pick.registry.hidden_files,                                           keymap = { "n", "<leader>ff" }, silent = true },
    { name = "File: Recent",                   exec = pick.builtin.buffers,                                                 keymap = { "n", "<leader>fr" }, silent = true },
    { name = "File: Grep",                     exec = pick.builtin.grep_live,                                               keymap = { "n", "<leader>fg" }, silent = true },
    { name = "File: Symbols in document",      exec = function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,  keymap = { "n", "<leader>fs" }, silent = true },
    { name = "File: Symbols in workspace",     exec = function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end, keymap = { "n", "<leader>fS" }, silent = true },
    { name = "File: Show unsaved changes",     exec = ":w !diff % -", },
    { name = "File: Type",                     exec = ":set filetype?", },
    { name = "File: Copy absolute path",       exec = [[:!echo %:p | tr -d '\n' | pbcopy]],                                 silent = true },
    { name = "File: Reload & Discard Changes", exec = feedkeys("e!") },

    { name = "Tab: Close all except current",  exec = ":tabonly" },
    {
        name = "Tab: Next",
        exec = ":tabnext",
        keymap = { "n", "gt" },
        silent = true
    },
    {
        name = "Tab: Previous",
        exec = ":tabprev",
        keymap = { "n", "gT" },
        silent = true
    },

    { name = "Window: Close all except current", exec = ":only" },
    {
        name = "Window: Close",
        exec = feedkeys("<C-w>q"),
        keymap = { "n", "<C-w>q" },
        silent = true
    },

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

    { name = "Char: ASCII",                      exec = feedkeys("ga"),                    keymap = { "n", "ga" },        silent = true },
    { name = "Char: Hex",                        exec = feedkeys("g8"),                    keymap = { "n", "g8" },        silent = true },


    { name = "Diff: All windows",                exec = ":windo diffthis", },
    { name = "Diff: Put",                        exec = ":diffput", },
    { name = "Diff: Get",                        exec = ":diffget", },

    { name = "Git: Blame",                       exec = gitsigns.blame_line,               keymap = { "n", "<leader>gb" } },
    { name = "Git: Diff this",                   exec = gitsigns.diffthis, },
    { name = "Git: Toggle blame",                exec = gitsigns.toggle_current_line_blame },
    { name = "Git: Toggle deleted",              exec = gitsigns.preview_hunk_inline },
    { name = "Git: Next hunk",                   exec = gitsigns.next_hunk,                keymap = { "n", "]g" } },
    { name = "Git: Previous hunk",               exec = gitsigns.prev_hunk,                keymap = { "n", "[g" } },
    { name = "Git: Reset hunk",                  exec = gitsigns.reset_hunk, },
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
    {
        name = "Lazygit: Open",
        exec = function()
            vim.cmd [[:tab term lazygit]]
            vim.defer_fn(feedkeys("a"), 100)
        end,
        keymap = { "n", "<leader>gg" }
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
