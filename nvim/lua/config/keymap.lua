-- ===== PATHS ================================================================================================================kmap
-- /Users/llaz/.local/state/nvim  Logs                   vim.fn.stdpath("log")
-- /Users/llaz/.local/share/nvim  Share (plugins, etc.)
--
-- ===== COMMANDS =============================================================================================================
-- vim.fn.stdpath("log")    Get standard path.
-- !column -ts $'\t'        Format text into table. Can also be done with `-ts '<C-v><tab>'`.
-- :Telescope resume        Open last Telescop session
-- :<,>DiffviewFileHistory  View history for selection portion of the code.
-- :grep someword *.zig     can be configured to use ripgrep or ag
-- :cfdo %s/foo/bar/g       preform a command on all quick fix FILES
-- :cdo? s/foo/bar/g        perform a command on all quick fix LINES
-- :%s/before/after/g       /g makes it global?; for new lines use \r
-- :s/before/after/         line only, /g applies multiple times, default only first match
-- :S/before/after/         case retaining mode BEFORE AFTER (from abolish plugin)
-- :g/r                     search with regex
-- :g/reges/d               delete all matches
-- :read !l                 Command output to current buffer
-- :'<,'>norm A;            Do motions and stuff on selection
-- :%norm A;                Do motions and stuff on all lines
-- :w ! .                   send current buffer content to command, ! is for bash and use % for file path
-- :'<,'>!c -ts '	'       formats as table
-- :'<,'>!s                 execute selection as bash script and replace with outputs
-- :ls                      list all buffers even closed and then :b index
-- :windo diffthis          diff two windows -> :tabnew <leader>- :enew :windo diffthis
--
-- TOOD: nvimtree, execute bash command on file in tree
-- TODO: auto complete lua in command mode
-- TODO: get auto compelte working in command window
--
-- ===== KEYMAPS ==============================================================================================================
-- <C-b>g      Tmux select file path
-- <C-v><Tab>  Insert TAB when spaces are used.
-- <C-o>       Execute one normal mode command in insert mode. Useful for Telescope <C-o>dd to change what you type.
-- g_          Go to last non-blank character.
-- { }         Jump by paragraph.
-- q:|Command mode for entering commands like in a buffer.
-- q/|Search mode for entering search term like in a buffer.
-- <C-w> + - expands, s - horizontal split, v - vertical split
-- <C-w> HJKL - moves window
-- <leader>m1 / `1  - Add mark jump to mark (upper case ones are global)
-- '.               - Jump to last edit
-- ''               - Last position before jump
--
-- i        - Go to test in neotest under cursor
--
-- cgn      - Change last search highlight
-- gn       - Visual select search highlight
-- g;       - Go to last edit
-- *        - Find selection or word under cursor
--
-- <leader>ma               - Add mark 'a'
-- 'a                       - Jump to mark a
-- :marks                   - See all marks
--
-- g<C-g>   - in visual mode show selected word count, etc.
--
-- gf       - go to file under cursor
-- gF       - go to file and line/column under cursor
-- <c-w>gf  - go to file under cursor in new tab
-- <c-w>f   - go to file under cursor in split
-- <c-w>q   - close window
-- <c-w>_   - maximize current window
--
-- <C-n>    - select words
-- [ ]      - move between selections
-- q/Q      - remove occurance
--
-- ]z and [z - jump between current fold ends
-- zM        - close all close all folds
-- zR        - open/reset all folds
-- zA        - opens all folds at current cursor
-- zf        - Fold anything in visual mode
-- aa        - While in visual mode go to next arg and select it <<<<<<<<<<<< AWESOME
-- ===========Telescope ==============
-- <C-v>    - open in vertical split
-- <C-t>    - open in new tab
-- Tab      - select items
-- <C-q>    - send selected items to qf list and open list
-- <C-j/k>  - navigate history
-- Actions are configured here: nvim/lua/plugins/telescope.lua
-- TODO: Advanced git search
-- TODO: builtin.oldfiles
--
--
-- ===== LUA ==================================================================================================================
-- log_level = vim.log.levels.DEBUG|property to use for plugin options
--
-- Check buffer type
-- if (vim.bo.buftype ~= 'TelescopePrompt') then
--
-- ===== fzf ============================================================================================
-- cd **<TAB>           path completion
-- kill -9 **<TAB>      pid completion
-- export **<TAB>       env var completion
-- unset **<TAB>        env var completion
-- .mp3$	            suffix-exact-match
-- ^music	            prefix-exact-match
-- !fire	            inverse-exact-match
-- <C-r>                command history commpletion
-- <C-t>                file path completion
-- <A-c>                cd with completion
--
-- TODO: https://freshman.tech/vim-quickfix-and-location-list/
-- TODO: tmux session for common stuff, like htop?
-- TODO: switch from tmux copy mode, to where terminal stuff is copied into new nvim instance
--tmux capture-pane -pS - | nvim 	
-- TODO: tmux pane switching using - and | same for vi
-- TODO: `gm` -> go modification, loop over git changes/hunks?
-- TODO: tailwind rn lsp
-- TODO: tree sitter query window like in here: https://www.youtube.com/watch?v=09-9LltqWLY
-- TODO: math operations on selection to het result
-- TODO: double bang !! etc, figure out how to execute selection or custom command and output into current file
-- TODO: execute commands from registers as macros (see theodore video from primeagen)
-- TODO: go to next git change, show git changes, undo hunk need keymaps easy to remember and incorporate
-- TODO: git blame
-- TODO: figure out <C-/> in telescope
-- TODO: autocomplete in command line when doing :lua require'dap', etc.
--
--
-- TODO
-- xnoremap - $
-- nnoremap - $
-- nnoremap Ud :vsc Team.Git.CompareWithUnmodified<cr>
-- nnoremap Us :vsc Team.Git.GoToGitChanges<cr>
-- nnoremap ]c :vsc Diff.NextDifference<cr>
-- nnoremap [c :vsc Diff.PreviousDifference<cr>
-- nnoremap g// :vsc Edit.FindinFiles<cr>          OR just use global grep?
-- nnoremap ]q :vsc Edit.GoToNextLocation<cr>
-- nnoremap [q :vsc Edit.GoToPrevLocation<cr>
--
--
-- attempt to map good ]x and [x mappings for all letters
-- ]q   - quickfixes
-- ]e   - errors
-- ]s   - searches
-- ]l   - locations
-- ]c   - changes
-- ]b   - break points
--
-- d]}  - delete to end of block
--
--
-- just use F10/F11 etc?
-- dc   - continue
-- drr  - run
-- dq   - quit
-- dp   - pause
-- drt  - test
-- dv   - variables (locals)
-- dk   - hover
-- db/dh- breakpoint
-- dn/dj- next (step over)
-- do/dk- out (step out)
-- ds/dl- step in
--
-- di/da/dt/df/de/dw/db - deletes
-- dh/dj/dk/dl - also deltes, but I don't use them, so better use them for debugging
--
-- callstack
-- repl
--
--
-- dig EXAMPLE.COM +noall +answer -t A      Show DNS records
-- mpg123                                   Sound player
-- `nvim --clean -u minimal.lua`            Minial init.lua for repros
--
--
--
-- ============================= VSCode =============================

-- vim.keymap.set("n", "<A-1>", function() require'bufferline'.go_to_buffer(1, true) end) -- Open 1st tab
-- vim.keymap.set("n", "<A-2>", function() require'bufferline'.go_to_buffer(2, true) end) -- Open 2nd tab
-- vim.keymap.set("n", "<A-3>", function() require'bufferline'.go_to_buffer(3, true) end) -- Open 3rd tab

-- vim.keymap.set("n", "<leader>k<S-CR>", require'bufferline'.toggle_pin) -- Toggle pin
-- vim.keymap.set("n", "<leader>wl", function()
--     for _, e in ipairs(require'bufferline'.get_elements().elements) do
--         vim.schedule(function()
--             vim.cmd("bd ".. e.id)
--         end)
--     end
-- end) -- Close all tabs


-- vim.keymap.set("n", "<C-tab>", "<cmd>BufferLineCycleNext<CR>") -- Open next tab
-- vim.keymap.set("n", "<C-S-tab>", "<cmd>BufferLineCyclePrev<CR>") -- Open previous tab

-- TODO: <leader>se <leader>sE
-- TODO: <C-S-Space>
-- TODO: <leader>ge <leader>gE <C-S-F12>
-- TODO: <leader>rr
-- TODO: <leader> kk kp kn kl BOOKMARKS

-- TODO: Terminal alt + up/down directory up
--
--https://github.com/sindrets/diffview.nvim
--https://github.com/mg979/vim-visual-multi

-- TODO: <leader>rt
-- TODO: <A-S;> <A-S-.> <A-S-jk>
-- TODO: <F5> continue while in debug
-- TODO: <leader>kc comment doesn't work with multiple lines selected
-- TODO: <leader>k <shift>enter pin tab
-- TODO: while in debug <shift>k -> debug: show hover or <leader>dh?
-- TODO: global zoom ctr+ -
--
-- TOOD: fix chrome Ctrl+L and Ctrl+F

--vim.keymap.set("n", "zz", function() vim.cmd.VSCodeNotifyVisual('workbench.action.showCommands', 1) end)

ls = require 'luasnip'

if vim.g.vscode then
    -- vim.keymap.set("v", "<A-j>", "[[<Cmd>call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 1)<CR>]]") -- Move selection down
    -- vim.keymap.set("v", "<A-k>", "[[<Cmd>call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 1)<CR>]]") -- Move selection up
    -- vim.keymap.set("n", "<A-j>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesDownAction')<CR>]]") -- Move current line down
    -- vim.keymap.set("n", "<A-k>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesUpAction')<CR>]]") -- Move current line down
    vim.keymap.set("n", "<leader>\\", "[[<Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>]]") -- Split window to side
    vim.keymap.set("n", "<leader>-", "[[<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>]]")   -- Split window down
    vim.keymap.set("n", "<A-k>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesUpAction')<CR>]]")          -- Move current line up
else
    -- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move selection down
    -- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move selection up
    -- vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<ESC>") -- Move current line down
    -- vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<ESC>") -- Move current line up
    vim.keymap.set("n", "<A-S-;>", "<Plug>(VM-Select-All)")         -- Select all occurances of current word
    vim.keymap.set("v", "<A-S-;>", "<Plug>(VM-Visual-All)")         -- Select all occurances of current word
    vim.keymap.set("n", "<A-S-j>", "<Plug>(VM-Add-Cursor-Down)")    -- Create cursor below
    vim.keymap.set("n", "<A-S-k>", "<Plug>(VM-Add-Cursor-Up)")      -- Create cursor above
    vim.keymap.set("n", "<A-LeftMouse>", "<Plug>(VM-Mouse-Cursor)") -- Create at mouse position
    vim.keymap.set("v", "<A-S-i>", "<Plug>(VM-Visual-Cursors)")     -- Creates a column of cursors from visual mode
    vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<CR>")            -- Split window to side
    vim.keymap.set("n", "<leader>-", "<cmd>split<CR>")              -- Split window down

    -- Marks (shadowed by cutlass/move)
    vim.keymap.set("n", "<leader>m", "m") -- Add mark
end

if vim.g.vscode then

else
    vim.keymap.set("n", "<C-A-l>", function()
        if vim.bo.filetype == 'DiffviewFiles' then
            vim.cmd [[DiffviewToggleFiles]]
        else
            -- Trying to use oil.nvim now.
            vim.cmd [[Oil]]
            -- Might ditch nvim-tree eventually.
            -- api = require 'nvim-tree.api'
            -- if api.tree.is_tree_buf() then
            --     api.tree.close()
            -- else
            --     api.tree.focus()
            -- end
        end
    end) -- Open netrw
    -- vim.keymap.set("n", "<C-A-l>", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
    -- vim.keymap.set("n", "<A-l>", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
    -- vim.keymap.set("n", "<leader>l", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
end

vim.keymap.set('x', 'p', '\"_dP')                  -- Paste without modifying register
vim.keymap.set("n", "<S-Del>", '"_dd')             -- Delete line without modifying registers
-- vim.keymap.set("n", "<C-A-l>", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
vim.keymap.set("v", "<S-Del>", '"_D')              -- Delete line without modifying registers
vim.keymap.set("n", "<BS>", 'h"_x')                -- Delete one character to left
vim.keymap.set("n", "<C-BS>", '"_db')              -- Delete one word to left
vim.keymap.set("i", "<C-BS>", '<C-w>')             -- Delete one word to left
vim.keymap.set("v", "y", "y`>")                    -- Yank and jump to end of the yanked text

vim.keymap.set("n", "YY", '"ayy:let @+ .= @a<CR>') -- Yank appending to existing clipboard
vim.keymap.set("v", "Y", '"ay`>:let @+ .= @a<CR>') -- Yank appending to existing clipboard

-- Just try to use q: and q/ defaults when needed.
-- Having this by default is sometimes annoying:
--  > Autocomplete doesn't work very well
--  > Command window is quite big and keeps appearing and moving cursor in the main buffer for some reason
-- vim.keymap.set("n", "q:", ":")
-- vim.keymap.set("n", ":", function()
--     if (vim.fn.win_gettype() == "command" or vim.bo.buftype == "nofile") then
--         -- Don't use command window when current window is already command, because this will error out.
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[:]], true, true, true), 'n', true)
--     else
--         -- Always use command window otherwise.
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[q:i]], true, true, true), 'n', true)
--     end
-- end)
--
-- vim.keymap.set("n", "/", function()
--     if (vim.fn.win_gettype() == "command" or vim.bo.buftype == "nofile") then
--         -- Don't use command window when current window is already command, because this will error out.
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[/]], true, true, true), 'n', true)
--     else
--         -- Always use command window otherwise.
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[q/i]], true, true, true), 'n', true)
--     end
-- end)
-- vim.keymap.set("n", "q/", "/")

-- The rest of these motions is handled by mini.move plugin.
vim.keymap.set("n", "<A-h>", '"hx2h"hp') -- Move character to left
vim.keymap.set("n", "<A-l>", '"hx"hp')   -- Move character to right
-- vim.keymap.set("v", "<A-h>", '"hd2h"hp`[v`]')                     -- Move character to left
-- vim.keymap.set("v", "<A-l>", '"hd"hp`[v`]')                       -- Move character to right

vim.keymap.set("n", "j", "gj") -- Move cursor down including wrapped lines
vim.keymap.set("n", "k", "gk") -- Move cursor up including wrapped lines

-- Just use *
-- vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>") -- Search selection in visual mode
vim.keymap.set("v", "<C-Enter>", "gx") -- Open selection with default app


vim.keymap.set("n", "Q", "<nop>")     -- ???

vim.keymap.set("n", "<leader>m", "m") -- Add mark (since 'm' is 'move' is my config)

vim.api.nvim_create_augroup('AutoFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.zig',
    group = 'AutoFormatting',
    callback = function()
        vim.lsp.buf.format({ --[[ async = true ]] }) -- Async formats stuff after save.
    end,
})

-- Source lua config files after save
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.lua" },
-- 	callback = function()
-- 		-- vim.lsp.buf.format()
-- 		vim.cmd([[source]])
-- 	end,
-- })


vim.keymap.set("n", "<S-Del>", '"_dd') -- Delete line without modifying registers
vim.keymap.set("v", "<S-Del>", '"_D')  -- Delete line without modifying registers
vim.keymap.set("n", "<BS>", 'h"_x')    -- Delete one character to left
vim.keymap.set("n", "<C-BS>", '"_db')  -- Delete one word to left
vim.keymap.set("i", "<C-BS>", '<C-w>') -- Delete one word to left
vim.keymap.set("v", "y", "y`>")        -- Yank and jump to end of the yanked text


vim.keymap.set("n", "J", "gJ")            -- Join lines without spaces in between

vim.keymap.set("n", "<C-n>", ":enew<CR>") -- New file
vim.keymap.set("n", "H", "^")             -- Jump to start of line
vim.keymap.set("v", "H", "^")             -- Jump to start of line
vim.keymap.set("n", "L", "$")             -- Jump to end of line
vim.keymap.set("v", "L", "$")             -- Jump to end of line

vim.keymap.set("n", "<CR>", "i<CR><ESC>") -- Break line in simple buffer

vim.api.nvim_create_autocmd('filetype', {
    pattern = 'qf',
    desc = 'Go to selection in quickfix buffer',
    callback = function()
        vim.keymap.set("n", "<CR>", "<CR><C-w>p", { remap = true, buffer = true })
    end
})
vim.keymap.set("n", "<S-CR>", "o")      -- Break line on next line
vim.keymap.set("n", "<C-CR>", "O")      -- Break line on previous line
vim.keymap.set("i", "<S-CR>", "<ESC>o") -- Break line on next line
vim.keymap.set("i", "<C-CR>", "<ESC>O") -- Break line on previous line

vim.keymap.set("v", "<", "<gv")         -- Indent left without losing visual selection
vim.keymap.set("v", ">", ">gv")         -- Indent right without losing visual selection
vim.keymap.set("v", "<S-TAB>", "<gv")   -- Indent right without losing visual selection
vim.keymap.set("v", "<TAB>", ">gv")     -- Indent right without losing visual selection
vim.keymap.set("n", "<S-TAB>", "<<")    -- Indent right without losing visual selection
vim.keymap.set("n", "<TAB>", ">>")      -- Indent right without losing visual selection
vim.keymap.set("n", "<C-a>", "gg^vG$")  -- Select all

vim.keymap.set("v", "<C-a>", "<C-a>gv") -- Increment numbers in visual mode without losing selection

if vim.g.vscode then
    vim.keymap.set("n", "<leader>rr", [[<Cmd>call VSCodeNotify('editor.action.rename')<CR>]])
    vim.keymap.set("n", "<leader>kc", [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])
    vim.keymap.set("v", "<leader>kc", [[<Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>]])
    vim.keymap.set("n", "<leader>ee", [[<Cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>]])
else
    -- Set up LSP shortcuts
    -- vim.keymap.set("n", "<leader>rr", '<cmd>Lspsaga rename<cr>')
    vim.keymap.set("n", "<leader>rr", '<cmd>lua LspRename()<cr>')
    vim.keymap.set("n", "<C-S-J>", '<cmd>lua require"illuminate".goto_next_reference{wrap=true}<cr>')    -- go to next symbol highlight
    vim.keymap.set("n", "<C-S-Down>", '<cmd>lua require"illuminate".goto_next_reference{wrap=true}<cr>') -- go to next symbol highlight
    vim.keymap.set("n", "<C-S-K>", '<cmd>lua require"illuminate".goto_prev_reference{wrap=true}<cr>')    -- go to previous symbol highlight
    vim.keymap.set("n", "<C-S-Up>", '<cmd>lua require"illuminate".goto_prev_reference{wrap=true}<cr>')   -- go to previous symbol highlight
    vim.keymap.set("n", "se", vim.diagnostic.open_float)                                                 -- show errors under cursor
    vim.keymap.set("n", "<leader>gd", require("telescope.builtin").lsp_definitions)                      -- Find definitions of symbol under cursor
    vim.keymap.set("n", "<C-.>", function() require("lspsaga.codeaction"):code_action() end)
    -- vim.keymap.set("n", "ppa", function() require("lspsaga.codeaction"):code_action() end)
    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end)

    -- vim.keymap.set('n', '<C-m><C-m>', 'za')
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end)

    vim.keymap.set('i', '<Tab>', function()
    end)

    vim.keymap.set({ "i" }, "<Tab>", function()
        if ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
        else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([[<Tab>]], true, true, true), 'n', true)
        end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })

    -- harpoon
    vim.keymap.set('n', '<leader>`', require "harpoon.ui".toggle_quick_menu)
    vim.keymap.set('n', '<leader>1', function() require "harpoon.ui".nav_file(1) end)
    vim.keymap.set('n', '<leader>2', function() require "harpoon.ui".nav_file(2) end)
    vim.keymap.set('n', '<leader>3', function() require "harpoon.ui".nav_file(3) end)
    vim.keymap.set('n', '<leader>4', function() require "harpoon.ui".nav_file(4) end)
    vim.keymap.set('n', '<leader>5', function() require "harpoon.ui".nav_file(5) end)
    vim.keymap.set('n', '<leader>6', function() require "harpoon.ui".nav_file(6) end)
    vim.keymap.set('n', '<leader>7', function() require "harpoon.ui".nav_file(7) end)
    vim.keymap.set('n', '<leader>8', function() require "harpoon.ui".nav_file(8) end)
    vim.keymap.set('n', '<leader>9', function() require "harpoon.ui".nav_file(9) end)
    vim.keymap.set('n', '<leader>k1', function() require "harpoon.mark".set_current_at(1) end)
    vim.keymap.set('n', '<leader>k2', function() require "harpoon.mark".set_current_at(2) end)
    vim.keymap.set('n', '<leader>k3', function() require "harpoon.mark".set_current_at(3) end)
    vim.keymap.set('n', '<leader>k4', function() require "harpoon.mark".set_current_at(4) end)
    vim.keymap.set('n', '<leader>k5', function() require "harpoon.mark".set_current_at(5) end)
    vim.keymap.set('n', '<leader>k6', function() require "harpoon.mark".set_current_at(6) end)
    vim.keymap.set('n', '<leader>k7', function() require "harpoon.mark".set_current_at(7) end)
    vim.keymap.set('n', '<leader>k8', function() require "harpoon.mark".set_current_at(8) end)
    vim.keymap.set('n', '<leader>k9', function() require "harpoon.mark".set_current_at(9) end)
    vim.keymap.set('n', '<leader>ą', function() require "harpoon.ui".nav_file(1) end)
    vim.keymap.set('n', '<leader>č', function() require "harpoon.ui".nav_file(2) end)
    vim.keymap.set('n', '<leader>ę', function() require "harpoon.ui".nav_file(3) end)
    vim.keymap.set('n', '<leader>ė', function() require "harpoon.ui".nav_file(4) end)
    vim.keymap.set('n', '<leader>į', function() require "harpoon.ui".nav_file(5) end)
    vim.keymap.set('n', '<leader>š', function() require "harpoon.ui".nav_file(6) end)
    vim.keymap.set('n', '<leader>ų', function() require "harpoon.ui".nav_file(7) end)
    vim.keymap.set('n', '<leader>ū', function() require "harpoon.ui".nav_file(8) end)
    vim.keymap.set('n', '<leader>ką', function() require "harpoon.mark".set_current_at(1) end)
    vim.keymap.set('n', '<leader>kč', function() require "harpoon.mark".set_current_at(2) end)
    vim.keymap.set('n', '<leader>kę', function() require "harpoon.mark".set_current_at(3) end)
    vim.keymap.set('n', '<leader>kė', function() require "harpoon.mark".set_current_at(4) end)
    vim.keymap.set('n', '<leader>kį', function() require "harpoon.mark".set_current_at(5) end)
    vim.keymap.set('n', '<leader>kš', function() require "harpoon.mark".set_current_at(6) end)
    vim.keymap.set('n', '<leader>kų', function() require "harpoon.mark".set_current_at(7) end)
    vim.keymap.set('n', '<leader>kū', function() require "harpoon.mark".set_current_at(8) end)
end


if vim.g.vscode then
    -- Nothing yet
else
    -- vim.keymap.set("n", "<C-p>", [[<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"]])
    vim.keymap.set("n", "<C-p>", [[<Cmd>Telescope find_files theme=dropdown<CR>]])
    --vim.keymap.set("n", "<C-p>", [[<Cmd>Telescope git_files theme=dropdown<CR>]])
    vim.keymap.set("n", "<C-f>", require("telescope.builtin").current_buffer_fuzzy_find) -- Find in current file's content
    vim.keymap.set("v", "<C-f>", function()
        local selection = vim.get_visual_selection()
        require("telescope.builtin").current_buffer_fuzzy_find({ default_text = selection })
    end)                                                                   -- Find in current file's content
    vim.keymap.set("n", "<C-S-f>", require("telescope.builtin").live_grep) -- Find file contents globally
    vim.keymap.set("v", "<C-S-f>", function()
        local selection = vim.get_visual_selection()
        require("telescope.builtin").live_grep({ default_text = selection })
    end)                                  -- Find file contents globally
    vim.keymap.set("n", "<C-->", "<C-O>") -- Go back
    vim.keymap.set("n", "<C-_>", "<C-I>") -- Go forward
end

if vim.g.vscode then
    -- Nothing yet
else
    vim.keymap.set("n", "<C-e>t", function()
        require("neotest").summary.toggle()
        local win = vim.fn.bufwinid("Neotest Summary")
        if win > -1 then
            vim.api.nvim_set_current_win(win)
        end
    end)

    vim.api.nvim_create_autocmd('filetype', {
        pattern = 'neotest-output',
        callback = function()
            -- Open file under cursor in the widest window available.
            vim.keymap.set('n', 'gF', function()
                local current_word = vim.fn.expand("<cWORD>")
                local tokens = vim.split(current_word, ":", { trimempty = true })
                local win_ids = vim.api.nvim_list_wins()
                local widest_win_id = -1;
                local widest_win_width = -1;
                for _, win_id in ipairs(win_ids) do
                    if (vim.api.nvim_win_get_config(win_id).zindex) then
                        -- Skip floating windows.
                        goto continue
                    end
                    local win_width = vim.api.nvim_win_get_width(win_id)
                    if (win_width > widest_win_width) then
                        widest_win_width = win_width
                        widest_win_id = win_id
                    end
                    ::continue::
                end
                vim.api.nvim_set_current_win(widest_win_id)
                if (#tokens == 1) then
                    vim.cmd("e " .. tokens[1])
                else
                    vim.cmd("e +" .. tokens[2] .. " " .. tokens[1])
                end
            end, { remap = true, buffer = true })
        end
    })

    vim.api.nvim_create_autocmd('filetype', {
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
                    print('Moved ' .. #source_paths .. ' items')
                end,
                { remap = true, buffer = true })
        end
    })

    vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true })
    vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true })
    vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true })
    vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true })
    vim.keymap.set("n", "<C-b><Right>", "<cmd>TmuxNavigateRight<CR>", { silent = true })
    vim.api.nvim_create_autocmd('filetype', {
        pattern = 'netrw',
        desc = 'Better mappings for netrw',
        callback = function()
            vim.keymap.set('n', 'a', '%', { remap = true, buffer = true })
            vim.keymap.set('n', 'r', 'R', { remap = true, buffer = true })
            vim.keymap.set('n', "<C-h>", "<cmd>TmuxNavigateLeft<CR>",
                { remap = true, buffer = true, silent = true })
            vim.keymap.set('n', "<C-j>", "<cmd>TmuxNavigateDown<CR>",
                { remap = true, buffer = true, silent = true })
            vim.keymap.set('n', "<C-k>", "<cmd>TmuxNavigateUp<CR>",
                { remap = true, buffer = true, silent = true })

            vim.keymap.set('n', "<C-l>", "<cmd>TmuxNavigateRight<CR>",
                { remap = true, buffer = true, silent = true })
        end
    })

    vim.api.nvim_create_autocmd('filetype', {
        pattern = 'lua',
        desc = 'Mappings for lua scripts',
        callback = function()
            vim.keymap.set('n', '<leader>re', function()
                vim.cmd [[w]]
                vim.cmd [[luafile %]]
                os.execute("sleep 0.1")
                vim.cmd [[messages]]
            end, { remap = true, buffer = true })
        end
    })

    vim.api.nvim_create_autocmd('filetype', {
        pattern = 'NvimTree',
        desc = 'Mappings for NvimTree',
        callback = function()
            -- Yank marked files
            vim.keymap.set('n', 'bgy',
                function()
                    local api = require 'nvim-tree.api'
                    local marks = api.marks.list()
                    if #marks == 0 then
                        print('No items marked')
                        return
                    end
                    local absolute_file_paths = ''
                    for _, mark in ipairs(marks) do
                        absolute_file_paths = absolute_file_paths .. mark.absolute_path .. '\n'
                    end
                    -- Using system registers for multi-instance support.
                    vim.fn.setreg("+", absolute_file_paths)
                    print('Yanked ' .. #marks .. ' items')
                end,
                { remap = true, buffer = true })

            -- Paste files
            vim.keymap.set('n', 'gp',
                function()
                    local api = require 'nvim-tree.api'
                    local source_paths = {}
                    for path in vim.fn.getreg('+'):gmatch('[^\n%s]+') do
                        source_paths[#source_paths + 1] = path
                    end
                    local node = api.tree.get_node_under_cursor()
                    local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
                    local target_path = is_folder and node.absolute_path or
                        vim.fn.fnamemodify(node.absolute_path, ":h")
                    if (vim.fn.filereadable(target_path)) then
                        -- File already exists, give a different name
                        target_path = vim.fn.input("Target path: ", target_path, "file")
                    end
                    for _, source_path in ipairs(source_paths) do
                        vim.fn.system { 'cp', '-R', source_path, target_path }
                    end
                    api.tree.reload()
                    print('Pasted ' .. #source_paths .. ' items')
                end,
                { remap = true, buffer = true })
            -- Paste files
            vim.keymap.set('n', 'gm',
                function()
                    local api = require 'nvim-tree.api'
                    local source_paths = {}
                    for path in vim.fn.getreg('+'):gmatch('[^\n%s]+') do
                        source_paths[#source_paths + 1] = path
                    end
                    local node = api.tree.get_node_under_cursor()
                    local is_folder = node.fs_stat and node.fs_stat.type == 'directory' or false
                    local target_path = is_folder and node.absolute_path or
                        vim.fn.fnamemodify(node.absolute_path, ":h")
                    for _, source_path in ipairs(source_paths) do
                        vim.fn.system { 'mv', source_path, target_path }
                    end
                    api.tree.reload()
                    print('Pasted ' .. #source_paths .. ' items')
                end,
                { remap = true, buffer = true })
        end
    })

    vim.keymap.set("n", "<C-S-p>", require 'scripts.my-commands', { silent = true }) -- scripts/my-commands.lua

    vim.keymap.set("n", "<C-b><Right>", "<cmd>TmuxNavigateRight<CR>", { silent = true })

    -- TODO: hjkl navigation and <C-MM>(za?) expand shrink https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes
    --
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#filter-directories-with-live-filter
end
