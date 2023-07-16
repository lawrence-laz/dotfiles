-- Use ':map' to see active mappings for debugging purposes.
-- ============================================================================
-- ----------------------------------------------------------------------------
-- <C-V> j/k g<C-a> -> enumerate block with sequence of numbers
-- <~> -> Change case
-- VISUAL MODE: `gx` -> open selection with gnome-open/open
-- % -> goes to next matching brace
-- cit --> change insite tag
-- ea --> end (word) append / bi --> back (word) insert
-- cip --> change inside paragraph
-- gv --> select last visual selection
-- gf --> open selected path in new tab
-- } and { --> in visual mode and other things move paragraph
-- Smyvariable<CR> --> jump to anywhere
-- **W --> all words around whitespaces
-- o (visual mode) --> jumo between ends
-- ZZ --> save and exit
-- ZQ --> don't save and exit
-- f" --> find quotes (same line)
-- ; --> go to next find
-- , --> go back find
-- <C-k> to view method signature and current param
-- <C-S-Space> to view docs for element under carret
-- <C-^> jump between two last files
-- * search word or visual selection

-- \\A\\Cc - convert to camel case, P PascalCale, S SNAKE_UPPERCASE, <space>, -, U, u
-- multiline + \\N - number row
-- Visual mode: <C-n> n n n - select next occurance of selection for multi cursor

-- hjkl mappings
-- Ctrl word/half page jumps
-- Shift join line, etc.
-- Alt move line/character
-- Shift+Alt multiline
-- Ctrl+Alt toggle file tree  (could be sacrificed?)
-- Ctrl+Shift go to next usage of symbol
-- ============================================================================
-- br or broot
-- ============================================================================
-- while entering a command argument <C-p> --> new pane select item <C-p> to confirm
-- <space> and : work for starting verb
-- configuration allows custom verbs https://dystroy.org/broot/conf_verbs/#verbs-shortcuts-and-keys
-- ! prefix --> execute in new panel


-- Oh how I wish <meta+hjkl> would work to jump between i3 windows, tmux panes and vim splits
-- TODO: add broot config 3 panes for files|staging|<C-p> with target


-- TODO: auto complete in command line with paths doesn't work??

-- TODO:
-- TRY OUT IMGUI.NET
-- DO A PROOF OF CONCEPT WITH SCA LIKE WINDOWS
-- https://github.com/mellinoe/ImGui.NET
-- PRESENT TO DEVS, this could be amazing

-- TODO: <C-S-j/k> jump between non-lsp words/selections, I used tome fork for this, see old nvim_backup config
-- TODO: nvim-cmp jump with tab between snippet placeholders
-- todo: <C-S-F> history <C-Up>

-- TODO:
--
-- https://github.com/tpope/vim-dadbod
-- https://github.com/kristijanhusak/vim-dadbod-ui
-- https://github.com/kristijanhusak/vim-dadbod-completion
--

-- Diff clibpard to visual selection, extend Diff: New split


-- TODO: nvim-tree show diagnostic errors, etc.




-- TODO!!!!!!!!!!!!!!!!!!!!!!!
-- <C-k><C-S> or just <leader>ks -> surround with snippets, would be nice

vim.g.mapleader = " " -- Key for <leader>

-- Diff clipboard with visual selection
vim.keymap.set("x", "<Leader>dd", function()
	local ftype = vim.api.nvim_eval("&filetype")
	vim.cmd(string.format(
		[[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
		ftype,
		ftype
	))
end)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move selection down 
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move selection up 
vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<ESC>") -- Move current line down 
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<ESC>") -- Move current line up 
vim.keymap.set("n", "<A-h>", '"hx2h"hp') -- Move character to left
vim.keymap.set("n", "<A-l>", '"hx"hp') -- Move character to right
vim.keymap.set("v", "<A-h>", '"hd2h"hp`[v`]') -- Move character to left
vim.keymap.set("v", "<A-l>", '"hd"hp`[v`]') -- Move character to right

vim.keymap.set("n", "j", "gj") -- Move cursor down including wrapped lines
vim.keymap.set("n", "k", "gk") -- Move cursor up including wrapped lines

vim.keymap.set("n", "<C-->", "<C-O>") -- Go back
vim.keymap.set("n", "<C-_>", "<C-I>") -- Go forward

vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>") -- Search selection in visual mode
vim.keymap.set("v", "<C-Enter>", "gx") -- Open selection with default app

vim.keymap.set("n", "Q", "<nop>") -- ???

-- Source lua config files after save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.lua" },
	callback = function()
		-- vim.lsp.buf.format()
		vim.cmd([[source]])
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.cs", "*.js", "*.jsx", "*.ts", "*.tsx", "*.rs" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- packer.lua auto :so and PackerSync on change?

-- File specific autocmd example
--vim.api.nvim_create_autocmd({"BufEnter", "BufNew"}, {
--    pattern = {"*.md"},
--    callback = function()
--    end
--})

-- Deleting motions are implemented by 'vim-cutlass'
-- vim.keymap.set('n', 'c', '"_c') -- Change text without modifying registers
-- vim.keymap.set('n', 'C', '"_C') -- Change text without modifying registers
-- vim.keymap.set('n', 'd', '"_d') -- Delete text without modifying registers
-- vim.keymap.set('n', 'x', '"_x') -- Delete character without modifying registers
vim.keymap.set('x', 'p', '\"_dP') -- Paste without modifying register
vim.keymap.set("n", "<S-Del>", '"_dd') -- Delete line without modifying registers
vim.keymap.set("v", "<S-Del>", '"_D') -- Delete line without modifying registers
vim.keymap.set("n", "<BS>", 'h"_x') -- Delete one character to left
vim.keymap.set("n", "<C-BS>", '"_db') -- Delete one word to left
vim.keymap.set("i", "<C-BS>", '<C-w>') -- Delete one word to left
vim.keymap.set("v", "y", "y`>") -- Yank and jump to end of the yanked text

-- Folding
vim.keymap.set("n", "<C-S-[>", "zc") -- Fold current
vim.keymap.set("n", "<C-S-]>", "zo") -- Unfold current

vim.keymap.set("n", "J", "gJ") -- Join lines without spaces in between
vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>") -- Search selection in visual mode

-- Retired in favor of tmux/vim pane movement
-- vim.keymap.set("n", "<C-l>", "w") -- Go word forwards
-- vim.keymap.set("v", "<C-l>", "w") -- Go word forwards
-- vim.keymap.set("n", "<C-h>", "b") -- Go word backwards
-- vim.keymap.set("v", "<C-h>", "b") -- Go word backwards
--
-- vim.keymap.set("n", "<C-j>", "<C-d>") -- Go half-page down
-- vim.keymap.set("n", "<C-k>", "<C-u>") -- Go half-page up
-- vim.keymap.set("v", "<C-j>", "<C-d>") -- Go half-page down
-- vim.keymap.set("v", "<C-k>", "<C-u>") -- Go half-page up
vim.keymap.set("n", "<C-n>", ":enew<CR>") -- New file
vim.keymap.set("n", "H", "^") -- Jump to start of line
vim.keymap.set("v", "H", "^") -- Jump to start of line
vim.keymap.set("n", "L", "$") -- Jump to end of line
vim.keymap.set("v", "L", "$") -- Jump to end of line

vim.keymap.set("n", "<CR>", "i<CR><ESC>") -- Break line
vim.keymap.set("n", "<S-CR>", "o") -- Break line on next line
vim.keymap.set("n", "<C-CR>", "O") -- Break line on previous line
vim.keymap.set("i", "<S-CR>", "<ESC>o") -- Break line on next line
vim.keymap.set("i", "<C-CR>", "<ESC>O") -- Break line on previous line

-- Insert line break keeping cursor unmoved
--nnoremap oo m`o<ESC>``
--nnoremap OO m`O<ESC>``
vim.keymap.set("v", "<", "<gv") -- Indent left without losing visual selection
vim.keymap.set("v", ">", ">gv") -- Indent right without losing visual selection
vim.keymap.set("v", "<S-TAB>", "<gv") -- Indent right without losing visual selection
vim.keymap.set("v", "<TAB>", ">gv") -- Indent right without losing visual selection
vim.keymap.set("n", "<S-TAB>", "<<") -- Indent right without losing visual selection
vim.keymap.set("n", "<TAB>", ">>") -- Indent right without losing visual selection
vim.keymap.set("n", "<C-a>", "gg^vG$") -- Select all

-- Retired in favor of the default "go down half a page"
-- vim.keymap.set("n", "<C-d>", "<cmd>copy .<CR>") -- Duplicate line
-- vim.keymap.set("v", "<C-d>", "y'>o<Esc>pgv") -- Duplicate line
vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<CR>") -- Split window to side
vim.keymap.set("n", "<leader>-", "<cmd>split<CR>") -- Split window down

vim.keymap.set("n", "<leader>is", "<cmd>Telescope symbols<CR>") -- Insert symbols
vim.keymap.set("n", "<leader>is", "<cmd>Telescope symbols<CR>") -- Insert symbols
vim.keymap.set("n", "<leader>is", "<cmd>Telescope symbols<CR>") -- Insert symbols
