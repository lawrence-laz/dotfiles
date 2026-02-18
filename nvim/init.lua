local os = vim.loop.os_uname().sysname
local is_windows = os == "Windows_NT"
local is_darwin = os == "Darwin"

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- So that file watchers would not freak out about deleted files.
vim.cmd [[set backupcopy=yes]]

if vim.g.neovide == true then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_scroll_animation_length = 0.10
    vim.keymap.set({ "n", "v" }, "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>")
    vim.keymap.set({ "n", "v" }, "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>",
        ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
end

-- ----------------------------------------------------------------
-- Colorscheme
-- ----------------------------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("MyColorScheme", { clear = true }),
    pattern = "habamax",
    callback = function()
        vim.opt.termguicolors = true
        vim.api.nvim_set_hl(0, "Normal", { fg = "#c0c0c0", bg = "#000000" })                  -- Background black, text whitish
        vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#000000" })                             -- Filler area
        vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9a9a", bg = "#0d0d0d" })                 -- Inactive tabs
        vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#ffffff", bg = "#1a1a1a", bold = true }) -- Active tab
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1a1a1a", bg = "#000000" })            -- Window separator (nvim 0.7+)
        vim.api.nvim_set_hl(0, "VertSplit", { fg = "#1a1a1a", bg = "#000000" })               -- Window separator (older nvim)
        vim.api.nvim_set_hl(0, "StatusLine", { fg = "#9a9a9a", bg = "#000000" })              -- Active window status line
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#6f6f6f", bg = "#000000" })            -- Inactive window status line
        vim.api.nvim_set_hl(0, "Search", { fg = "#eaeaea", bg = "#2a2a2a", })
        vim.api.nvim_set_hl(0, "CurSearch", { fg = "#000000", bg = "#b0b0b0", bold = true, })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "#000000", bg = "#b0b0b0", bold = true, })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#3a3a3a" })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#3a3a3a" })
        vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Visual" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })

        vim.api.nvim_set_hl(0, "MiniPickNormal", { fg = "#b8b8b8", bg = "#000000" })
        vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = "#ffffff", bold = true })
        vim.api.nvim_set_hl(0, "MiniPickBorder", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "MiniPickBorderText", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "MiniPickPrompt", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { bg = "#000000" })

        vim.api.nvim_set_hl(0, "@string", { fg = "#5fdd5f" })
        vim.api.nvim_set_hl(0, "Constant", { fg = "#ff60af" })
        vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#ff60af" })
        vim.api.nvim_set_hl(0, "Identifier", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "@constructor", { fg = "#ffffff", bg = "#333355" })
        vim.api.nvim_set_hl(0, "@constructor.lua", { link = "Special", bg = "NONE" })

        vim.api.nvim_set_hl(0, "Type", { fg = "#5487dd" })
        vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })

        vim.api.nvim_set_hl(0, "@keyword.exception", { fg = "#cc4444", bg = "NONE" })

        vim.api.nvim_set_hl(0, "Statement", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "@keyword", { fg = "#cccccc" })
        vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = "#dcc16d" })
        vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = "#dcc16d" })
        vim.api.nvim_set_hl(0, "@keyword.return", { fg = "#dcc16d" })
        vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#dcc16d" })
        vim.api.nvim_set_hl(0, "@keyword.type", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "@keyword.import", { fg = "#cccccc" })
        vim.api.nvim_set_hl(0, "@keyword.modifier", { fg = "#cccccc" })

        vim.api.nvim_set_hl(0, "@function.call", { fg = "#dcc16d" })
        vim.api.nvim_set_hl(0, "@method.call", { link = "@function.call" })
        vim.api.nvim_set_hl(0, "@function.method.call", { link = "@function.call" })
        vim.api.nvim_set_hl(0, "@function.method", { link = "@function.call" })
    end,
})
vim.cmd.colorscheme("habamax")

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

local function copy_path(src, dst)
    if is_windows then
        if vim.fn.isdirectory(src) == 1 then
            -- robocopy copies *contents*; create target dir name explicitly
            local name = vim.fn.fnamemodify(src, ":t")
            vim.fn.system({ "robocopy", src, dst .. "\\" .. name, "/E" })
        else
            vim.fn.system({ "cmd", "/c", "copy", src, dst })
        end
    else
        vim.fn.system({ "cp", "-R", src, dst })
    end
end

local function move_path(src, dst)
    if is_windows then
        if vim.fn.isdirectory(src) == 1 then
            local name = vim.fn.fnamemodify(src, ":t")
            vim.fn.system({ "robocopy", src, dst .. "\\" .. name, "/E", "/MOVE" })
            -- robocopy leaves empty dirs sometimes
            vim.fn.system({ "cmd", "/c", "rmdir", src })
        else
            vim.fn.system({ "cmd", "/c", "move", src, dst })
        end
    else
        vim.fn.system({ "mv", src, dst })
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

local extract_archive = function(file_path)
    local stat = vim.loop.fs_stat(file_path)
    if not stat or stat.type ~= "file" then
        vim.notify("Not a file: " .. file_path, vim.log.levels.ERROR)
        return
    end

    local ext = file_path:lower()
    local parent = vim.fn.fnamemodify(file_path, ":h")
    local base = vim.fn.fnamemodify(file_path, ":t:r")
    local dest = path_join(parent, base)

    if not exists(dest) then
        vim.loop.fs_mkdir(dest, 493) -- 0755
    end

    local sys = vim.loop.os_uname().sysname
    local handle

    if sys == "Darwin" then
        if ext:match("%.zip$") or ext:match("%.nupkg$") then
            -- existing ZIP code
            handle = vim.loop.spawn(
                "unzip",
                { args = { "-o", file_path, "-d", dest }, stdio = { nil, nil, nil } },
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
        elseif ext:match("%.tar%.gz$") or ext:match("%.tgz$") then
            -- new tar.gz branch
            handle = vim.loop.spawn(
                "tar",
                { args = { "-xzf", file_path, "-C", dest }, stdio = { nil, nil, nil } },
                function(code)
                    if handle then handle:close() end
                    vim.schedule(function()
                        if code == 0 then
                            vim.notify("Extracted tar.gz to " .. dest)
                        else
                            vim.notify("tar.gz extraction failed", vim.log.levels.ERROR)
                        end
                    end)
                end
            )
        else
            vim.notify("Unsupported archive type", vim.log.levels.ERROR)
        end

        if not handle then
            vim.notify("Failed to start extraction command", vim.log.levels.ERROR)
        end
    elseif sys == "Windows_NT" then
        local handle
        handle = vim.loop.spawn(
            "tar",
            {
                args = { "-xf", zip_path, "-C", dest },
                stdio = { nil, nil, nil },
            },
            function(code)
                if handle then handle:close() end
                vim.schedule(function()
                    if code == 0 then
                        vim.notify("Extracted to " .. dest)
                    else
                        vim.notify("Zip extraction failed (tar)", vim.log.levels.ERROR)
                    end
                end)
            end
        )

        if not handle then
            vim.notify("Failed to start tar", vim.log.levels.ERROR)
        end
    else
        vim.notify("Unsupported OS for extraction", vim.log.levels.ERROR)
    end
end

local lowercase_cabbrev = function(cmd)
    local lower = cmd:lower()

    vim.cmd(string.format([[
        cnoreabbrev <expr> %s getcmdtype() == ":" && getcmdline() == "%s" ? "%s" : "%s"
    ]], lower, lower, cmd, lower))
end

local open_todo = function()
    local root = nil

    -- Try to get git repo root
    local git_root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })
    if vim.v.shell_error == 0 and git_root[1] and git_root[1] ~= "" then
        root = git_root[1]
    else
        root = vim.loop.cwd()
    end

    local todo_path = root .. "/todo.md"

    -- Create file if it doesn't exist
    if vim.fn.filereadable(todo_path) == 0 then
        local fd = vim.loop.fs_open(todo_path, "w", 420) -- 0644
        if fd then
            vim.loop.fs_close(fd)
        else
            vim.notify("Failed to create todo.md", vim.log.levels.ERROR)
            return
        end
    end

    -- Open in new tab
    vim.cmd.tabedit(vim.fn.fnameescape(todo_path))
end
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
--
-- :`<,`>write !git apply           Apply selected text as git patch (or provide -R to reverse)

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
    group = vim.api.nvim_create_augroup("MyQuickFix", { clear = true }),
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
    { src = 'https://github.com/echasnovski/mini.extra',              version = "7c0a674" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/JanikkinaJ/lazydev.nvim',             version = "ca311b8" }, -- https://github.com/folke/lazydev.nvim/issues/114
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git', branch = 'master' },
    { src = 'https://github.com/ThePrimeagen/harpoon' },
    { src = "https://github.com/seblyng/roslyn.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/kmiterror/dotnet-debug.nvim" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/tpope/vim-abolish" },
})


if is_windows then
    -- Stub for dotnet-debug
    if not package.loaded["dapui"] then
        package.preload["dapui"] = function()
            return {
                setup = function(_) end,
                open = function() end,
            }
        end
    end
    -- Ensure file exists, othrewise dotnet-debug does not do its thing
    local script = vim.fn.stdpath("cache") .. "/handshake_signer.js"
    vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
    if not vim.loop.fs_stat(script) then vim.fn.writefile({}, script) end

    require("dotnet-debug").setup({
        signer_path =
        "C:/Users/laurynas.lazauskas/AppData/Local/Programs/Microsoft VS Code/resources/app/node_modules.asar.unpacked/vsda/build/Release/vsda.node",
        debugger_path = resolve_glob(
        "C:/Users/laurynas.lazauskas/.vscode/extensions/ms-dotnettools.csharp-*/.debugger/x86_64/vsdbg-ui.exe"),
    })

    require("dap").configurations.cs = {
        {
            type = 'coreclr',
            name = 'Attach to .NET process',
            request = 'attach',
            processId = require('dap.utils').pick_process,
            justMyCode = false,
            stopAtEntry = false,
            cwd = vim.fn.getcwd(),
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

    require("nvim-dap-virtual-text").setup()
end

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
    --vim.uv.os_setenv(rg_env, vim.fn.stdpath('config') .. '/' .. config_name)
    action()
    vim.uv.os_setenv(rg_env, prev_config)
end
pick.registry.hidden_files = function()
    with_rg_config('hidden', function()
        pick.builtin.files({ tool = 'rg' })
    end)
end

pick.registry.grep_live_smart_case = function()
    with_rg_config('grep_live_smart_case', function()
        pick.builtin.grep_live({ tool = 'rg' })
    end)
end

pick.registry.grep_live_max = function()
    with_rg_config('grep_live.conf', function()
        pick.builtin.grep_live({ tool = 'rg' })
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
    group = vim.api.nvim_create_augroup("MyOil", { clear = true }),
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
                    copy_path(source_path, target_path)
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
                    move_path(source_path, target_path)
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

            extract_archive(path_join(cwd, entry.name))
            vim.cmd("e!")
        end, {})
        lowercase_cabbrev("Extract")
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    callback = function()
        -- Move out files from directory under cursor and delete the dir
        vim.api.nvim_create_user_command("Run", function()
            vim.cmd [[tab term zig build run -freference-trace=8]]
        end, {})
        lowercase_cabbrev("Run")
    end
})

vim.api.nvim_create_user_command("DiffUnsaved", function()
    local file = vim.fn.expand("%:p")
    if file == "" then
        file = vim.fn.expand("#:p")
    end

    vim.cmd("vert new")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.buflisted = false

    if file ~= "" and vim.fn.filereadable(file) == 1 then
        vim.cmd("silent 0read ++edit " .. vim.fn.fnameescape(file))
        vim.cmd("silent 1delete _") -- remove the initial empty line from :new
    end

    vim.cmd("diffthis")
    vim.cmd("wincmd p")
    vim.cmd("diffthis")
end, {})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(ev)
        local function jump_from_term()
            -- When there are more than one tab open I am likely running
            -- a build/test command in a separate tab and would like for
            -- `gF` to operate not on this tab, but on previous one.
            if #vim.api.nvim_list_tabpages() <= 1 then
                vim.cmd("normal! gF")
                return
            end
            local cword = vim.fn.expand("<cWORD>"):gsub(":$", "") -- remove trailing colon
            local path, lnum, col = cword:match("^(.-):(%d+):(%d+)$")
            if not path then path, lnum = cword:match("^(.-):(%d+)$") end
            if not path then path = cword end
            vim.cmd("stopinsert|tabclose|edit " .. vim.fn.fnameescape(path))
            if lnum then vim.api.nvim_win_set_cursor(0, { tonumber(lnum), col and tonumber(col) - 1 or 0 }) end
        end

        vim.keymap.set("t", "gF", jump_from_term, { buffer = ev.buf, silent = true })
        vim.keymap.set("n", "gF", jump_from_term, { buffer = ev.buf, silent = true })
    end,
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
    group = vim.api.nvim_create_augroup("MyMarkdown", { clear = true }),
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
-- C#
-- ----------------------------------------------------------------

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.cs",
    callback = function(args)
        if vim.bo[args.buf].modifiable then
            vim.cmd [[silent! !dotnet-csharpier %]]
        end
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("MyDotnetRun", { clear = true }),
    pattern = 'cs',
    callback = function()
        vim.api.nvim_create_user_command("Run", function()
            vim.cmd [[tab term dotnet run]]
        end, {})
        vim.api.nvim_create_user_command("Build", function()
            vim.cmd [[tab term dotnet build]]
        end, {})
        vim.api.nvim_create_user_command("Test", function()
            vim.cmd [[tab term dotnet test]]
        end, {})
    end
})

-- ----------------------------------------------------------------
-- LSP
-- ----------------------------------------------------------------

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.workspace = capabilities.workspace or {}
-- capabilities.workspace.didChangeWatchedFiles = {
--     dynamicRegistration = true,
-- }

-- Turn off LSP semantic tokens (treesitter FTW?)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

if is_darwin then
    vim.lsp.config('roslyn', {
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
    vim.lsp.config('roslyn', {
        cmd = { 'C:/Program Files/dotnet/dotnet.exe',
            resolve_glob(
                'C:/Users/laurynas.lazauskas/.vscode/extensions/ms-dotnettools.csharp-*/.roslyn/Microsoft.CodeAnalysis.LanguageServer.dll'),
            '--logLevel',
            'Information',
            '--extensionLogDirectory',
            vim.fs.joinpath(vim.uv.os_tmpdir(),
                'roslyn_ls/logs'), '--stdio' }
    })
end

require("roslyn").setup({
    filewatching = "roslyn",
})

vim.lsp.config("roslyn", {
    capabilities = capabilities,
    settings = {
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles"
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = false
        },
        ["csharp|completion"] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true
        },
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = false,
            csharp_enable_inlay_hints_for_implicit_variable_types = false,
            csharp_enable_inlay_hints_for_lambda_parameter_types = false,
            csharp_enable_inlay_hints_for_types = false,
            dotnet_enable_inlay_hints_for_indexer_parameters = false,
            dotnet_enable_inlay_hints_for_literal_parameters = false,
            dotnet_enable_inlay_hints_for_object_creation_parameters = false,
            dotnet_enable_inlay_hints_for_other_parameters = false,
            dotnet_enable_inlay_hints_for_parameters = false,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true
        },
        ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true
        }
    }
})

vim.lsp.enable({
    'lua_ls',
    'zls',
    -- 'roslyn_ls',
})

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
    underline = true,
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

-- DAP
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

-- This is a custom function to support LSP like hovering where the first invocation only shows the window, but does not jump to it,
-- and the second invocation makes it jump inside the floating window.
-- (It's not very nice, because I had to copy some internal functions to make this work, related issue https://github.com/mfussenegger/nvim-dap/issues/1194
function Dap_better_hover_old(expr, winopts)
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

-- One function for both normal/visual cases.
function Dap_better_hover(expr, winopts)
    local dap = require('dap')
    local session = dap.session()
    if not session then return vim.notify("DAP: no active session", vim.log.levels.WARN) end

    local mode         = vim.api.nvim_get_mode().mode
    local label        = dap_eval_expression(expr) or "<cexpr>"

    -- Create (or jump to) a focusable float; first call just opens it.
    local bufnr, winid = vim.lsp.util.open_floating_preview({}, "dap-float", vim.tbl_deep_extend("force", {
        focusable    = true,
        close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
        focus_id     = 'dappp',
        focus        = true,
        width        = 100,
        height       = 5,
    }, winopts or {}))

    -- If buffer already existed we just focused it; keep your “second tap to focus” UX.
    if #vim.api.nvim_buf_get_lines(bufnr, 1, 999, false) ~= 0 then return end

    -- Common buffer/window setup
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].filetype  = "dap-float"
    vim.bo[bufnr].buftype   = "nofile"
    vim.api.nvim_buf_set_name(bufnr, ('dap-hover-%d: %s'):format(bufnr, label))
    vim.wo[winid].scrolloff = 0

    -- Common actions
    vim.keymap.set("n", "<CR>", function() require('dap.ui').trigger_actions({ mode = 'first' }) end, { buffer = bufnr })
    vim.keymap.set("n", "a", function() require('dap.ui').trigger_actions() end, { buffer = bufnr })
    vim.keymap.set("n", "o", function() require('dap.ui').trigger_actions() end, { buffer = bufnr })
    vim.keymap.set("n", "<2-LeftMouse>", function() require('dap.ui').trigger_actions() end, { buffer = bufnr })

    -- Branch by mode:
    if mode == 'v' or mode == 'V' then
        -- VISUAL: REPL-context evaluation in-frame (avoid global-scope errors)
        local frame = session.current_frame
        if not (frame and frame.id) then
            pcall(vim.api.nvim_win_close, winid, true)
            return vim.notify("DAP: no current frame. Pause/hit a breakpoint first.", vim.log.levels.WARN)
        end
        session:request("evaluate", { expression = label, context = "repl", frameId = frame.id }, function(err, res)
            if err then
                pcall(vim.api.nvim_win_close, winid, true)
                return vim.notify("DAP evaluate error: " .. (err.message or vim.inspect(err)), vim.log.levels.ERROR)
            end
            vim.bo[bufnr].modifiable = true
            local out = {
                -- "> " .. label,
                res and res.result or "<no result>"
            }
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, out)
            vim.bo[bufnr].modifiable = false
        end)
    else
        -- NORMAL: interactive hover (expandable tree; same “two-tap to focus”)
        local widgets = require("dap.ui.widgets")
        widgets.builder(widgets.expression)
            .new_buf(function() return bufnr end)
            .new_win(widgets.with_resize(function() return winid end))
            .build()
            .open(label)
    end
end

local commands = create_commands({

    { name = "Messages: History",                exec = ":new | put =execute('messages')" },
    { name = "Config: Relaod",                   exec = 'execute "source " . stdpath("config") . "/init.lua"' },


    { name = "Build: Make",                      exec = ":make", },

    { name = "Buffer: Delete (Close)",           exec = ":bd" },
    { name = "Buffer: Close all except current", exec = ":%bd|e#" },

    { name = "Debug: Run (Continue)",            exec = require 'dap'.continue,                                                keymap = { "n", "dr" } },
    { name = "Debug: Run last",                  exec = require 'dap'.run_last, },
    { name = "Debug: Stop (Pause)",              exec = require 'dap'.pause,                                                   keymap = { "n", "ds" } },
    { name = "Debug: Quit",                      exec = require 'dap'.terminate,                                               keymap = { "n", "dq" } },
    { name = "Debug: Open REPL",                 exec = require 'dap'.repl.open, },
    { name = "Debug: Go to current line",        exec = require 'dap'.focus_frame,                                             keymap = { "n", "<C-S-H>" } },
    { name = "Debug: Clear breakpoints",         exec = require 'dap'.clear_breakpoints(), },
    { name = "Debug: Toggle breakpoint",         exec = require 'dap'.toggle_breakpoint,                                       keymap = { "n", "<C-h>" } },
    { name = "Debug: Break on exception",        exec = require 'dap'.set_exception_breakpoints, },
    { name = "Debug: Step over",                 exec = require 'dap'.step_over,                                               keymap = { "n", "<C-j>" } },
    { name = "Debug: Run to cursor",             exec = require 'dap'.run_to_cursor,                                           keymap = { "n", "<C-S-J>" } },
    { name = "Debug: Step out",                  exec = require 'dap'.step_out,                                                keymap = { "n", "<C-k>" } },
    { name = "Debug: Hover",                     exec = Dap_better_hover,                                                      keymaps = { { "n", "<C-S-K>" }, { "v", "<C-S-K>" } } },
    { name = "Debug: Step into",                 exec = require 'dap'.step_into,                                               keymap = { "n", "<C-l>" } },
    { name = "Debug: Go to",                     exec = function() require 'dap'.goto_(vim.api.nvim_win_get_cursor(0)[1]) end, keymap = { "n", "<C-S-L>" } },
    { name = "Debug: Go up in callstack",        exec = require 'dap'.up,                                                      keymap = { "n", "[s" } },
    { name = "Debug: Go down in callstack",      exec = require 'dap'.down,                                                    keymap = { "n", "]s" } },
    {
        name = "Debug: Show callstack",
        exec = function()
            require 'dap.ui.widgets'.centered_float(require 'dap.ui.widgets'
                .frames)
        end
    },

    { name = "Edit: Wrap Text",      exec = feedkeys("gw"),                                 keymap = { "v", "gw" }, },
    -- Note 'gq' triggers LSP if it's attached.

    { name = "Config: Source",       exec = "exe 'source' stdpath('config') .. '/init.lua'" },

    { name = "LSP: Rename",          exec = vim.lsp.buf.rename,                             keymap = { "n", "grn" }, silent = true },
    { name = "LSP: Code Action",     exec = vim.lsp.buf.code_action,                        keymap = { "n", "gra" }, silent = true },
    { name = "LSP: References",      exec = vim.lsp.buf.references,                         keymap = { "n", "grr" }, silent = true },
    { name = "LSP: Implementation",  exec = vim.lsp.buf.implementation,                     keymap = { "n", "gri" }, silent = true },
    { name = "LSP: Type Definition", exec = vim.lsp.buf.type_definition,                    keymap = { "n", "grt" }, silent = true },
    { name = "LSP: Hover",           exec = vim.lsp.buf.hover,                              keymap = { "n", "K" },   silent = true },
    { name = "LSP: Document Symbol", exec = vim.lsp.buf.document_symbol,                    keymap = { "n", "gO" },  silent = true },
    {
        name = "LSP: Restart",
        exec = function()
            vim.diagnostic.reset()
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

    { name = "Diagnostic: Open Float",     exec = vim.diagnostic.open_float,                                                            keymap = { "n", "<C-w>d" }, silent = true },
    { name = "Diagnostic: Go to Next",     exec = vim.diagnostic.goto_next,                                                             keymap = { "n", "]e" },     silent = true },
    { name = "Diagnostic: Go to Previous", exec = vim.diagnostic.goto_prev,                                                             keymap = { "n", "[e" },     silent = true },
    { name = "Diagnostic: Reset",          exec = vim.diagnostic.reset },

    { name = "Fold: Toggle",               exec = feedkeys("za"),                                                                       keymap = { "n", "za" },     silent = true },
    { name = "Fold: Paragraph",            exec = feedkeys("zfip"),                                                                     keymap = { "n", "zfip" },   silent = true },
    { name = "Fold: Match",                exec = feedkeys("zf%"),                                                                      keymap = { "n", "zf%" },    silent = true },

    { name = "Quickfix: Open",             exec = "copen",                                                                              silent = true },
    { name = "Quickfix: Older",            exec = "colder",                                                                             keymap = { "n", "]Q" }, },
    { name = "Quickfix: Newer",            exec = "cnewer",                                                                             keymap = { "n", "[Q" }, },
    { name = "Quickfix: Errors",           exec = function() vim.diagnostic.setqflist({ severity = vim.diagnostic
        .severity.ERROR }) end },
    { name = "Quickfix: Warnings",         exec = function() vim.diagnostic.setqflist({ severity = vim.diagnostic
        .severity.WARN }) end },
    { name = "Quickfix: Info",             exec = function() vim.diagnostic.setqflist({ severity = vim.diagnostic
        .severity.INFO }) end },
    { name = "Quickfix: Diagnostics",      exec = function() vim.diagnostic.setqflist() end },
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
    { name = "Run",                            exec = ":Run",                                                               keymap = { "n", "<leader>r" },  silent = true },
    { name = "Build",                          exec = ":Build",                                                             keymap = { "n", "<leader>bb" }, silent = true },
    { name = "Test",                           exec = ":Test",                                                              keymap = { "n", "<leader>t" },  silent = true },

    { name = "File: Info",                     exec = feedkeys("g<C-g>"),                                                   keymap = { "n", "g<C-g>" },     silent = true },
    { name = "File: Find",                     exec = pick.registry.hidden_files,                                           keymap = { "n", "<leader>ff" }, silent = true },
    { name = "File: Recent",                   exec = pick.builtin.buffers,                                                 keymap = { "n", "<leader>fr" }, silent = true },
    { name = "File: Grep",                     exec = pick.registry.grep_live_smart_case,                                   keymap = { "n", "<leader>fg" }, silent = true },
    { name = "File: Symbols in document",      exec = function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end,  keymap = { "n", "<leader>fs" }, silent = true },
    { name = "File: Symbols in workspace",     exec = function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end, keymap = { "n", "<leader>fS" }, silent = true },
    { name = "File: Show unsaved changes",     exec = ":DiffUnsaved", },
    { name = "File: Type",                     exec = ":set filetype?", },
    { name = "File: Copy absolute path",       exec = [[:!echo %:p | tr -d '\n' | pbcopy]],                                 silent = true },
    { name = "File: Reload & Discard Changes", exec = feedkeys("e!") },
    { name = "File: Show CR",                  exec = ":e ++ff=unix" },

    { name = "Find: Negative lookbehind",      exec = feedkeys([[/\\(NOT_THIS\\)\\@<!THIS]]), },
    { name = "Find: Negative lookahead",       exec = feedkeys([[/THIS\\(NOT_THIS\\)\\@!]]), },

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
        name = "Window: Exchange",
        exec = feedkeys("<C-w>x"),
        keymap = { "n", "<C-w>x" },
        silent = true
    },
    {
        name = "Window: Horizontal",
        exec = feedkeys("<C-w>H"),
        keymap = { "n", "<C-w>H" },
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
    {
        name = "Window: Exchange",
        exec = feedkeys("<C-w>x"),
        keymap = { "n", "<C-w>x" },
        silent = true
    },
    {
        name = "Window: Horizontal",
        exec = feedkeys("<C-w>H"),
        keymap = { "n", "<C-w>H" },
        silent = true
    },

    { name = "Char: ASCII",                      exec = feedkeys("ga"),                    keymap = { "n", "ga" },        silent = true },
    { name = "Char: Hex",                        exec = feedkeys("g8"),                    keymap = { "n", "g8" },        silent = true },


    { name = "Diff: All windows",                exec = ":windo diffthis", },
    { name = "Diff: Put",                        exec = ":diffput",                        keymap = { "n", "dp" } },
    { name = "Diff: Get",                        exec = ":diffget",                        keymap = { "n", "do" } },

    { name = "Git: Blame",                       exec = gitsigns.blame_line,               keymap = { "n", "<leader>gb" } },
    -- { name = "Git: Diff this",                   exec = gitsigns.diffthis, },
    { name = "Git: Diff",                        exec = feedkeys(":Gvdiffsplit HEAD~1"), }, -- @{push} or branchname
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

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'zig',
    callback = function()
        vim.snippet.add(
            "dlog",
            "std.debug.print(\"${1:pattern}\\n\", .{${2:args}});",
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
