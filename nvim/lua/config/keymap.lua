vim.keymap.set("n", "<A-k>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesUpAction')<CR>]]") -- Move current line up 
-- ============================= VSCode =============================
--TODO:
	--- First try dotnet aoc
	--- if it sucks go through langs
--
--languages:
	--- c#
	--- go
	--- dart
	--- zig
	--- ocaml
--
--what to do:
	--- dart seems awesome (c# like, no MS)
	--- zig seems nice, but manual memory
	--- go seems simple, but verbose?
		--- need to try it out?
	--- c# seems nice, but MS
		--- also AOT kindof bad?
		--- need to try AOT build in macos
	--- ocaml seems cool and gc, but kind of new/functional heavy
--
--goal:
	--- devtooling, cli apps
	--- immediate mode TUI library



-- TODO: Get harpoon <A-1> <A-2> etc

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

-- TODO: command center with custom lua
-- TODO: <leader>se <leader>sE
-- TODO: <C-S-Space>
-- TODO: <leader>ge <leader>gE <C-S-F12>
-- TODO: <C-.>
-- TODO: <leader>kd -- format
-- TODO: <leader>rr
-- TODO: <leader> kk kp kn kl BOOKMARKS

-- TODO: <leader>rt
-- TODO: <A-S;> <A-S-.> <A-S-jk>
-- TODO: <F5> continue while in debug
-- TODO: <leader>kc comment doesn't work with multiple lines selected
-- TODO: <leader>k <shift>enter pin tab
-- TODO: while in debug <shift>k -> debug: show hover or <leader>dh?
-- TODO: <C-`> change case clashes with terminal, use <leader>st show terminal?
-- TODO: global zoom ctr+ -

--vim.keymap.set("n", "zz", function() vim.cmd.VSCodeNotifyVisual('workbench.action.showCommands', 1) end)

if vim.g.vscode then
	-- vim.keymap.set("v", "<A-j>", "[[<Cmd>call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 1)<CR>]]") -- Move selection down 
	-- vim.keymap.set("v", "<A-k>", "[[<Cmd>call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 1)<CR>]]") -- Move selection up 
	-- vim.keymap.set("n", "<A-j>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesDownAction')<CR>]]") -- Move current line down 
	-- vim.keymap.set("n", "<A-k>", "[[<Cmd>call VSCodeCall('editor.action.moveLinesUpAction')<CR>]]") -- Move current line down 
	vim.keymap.set("n", "<leader>\\", "[[<Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>]]") -- Split window to side
	vim.keymap.set("n", "<leader>-", "[[<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>]]") -- Split window down
else
	-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move selection down 
	-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move selection up 
	-- vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<ESC>") -- Move current line down 
	-- vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<ESC>") -- Move current line up 
	vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<CR>") -- Split window to side
	vim.keymap.set("n", "<leader>-", "<cmd>split<CR>") -- Split window down
end


if vim.g.vscode then
  -- Nothing
else
  vim.keymap.set("n", "<C-A-l>", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
  vim.keymap.set("n", "<A-l>", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
  vim.keymap.set("n", "<leader>l", "<cmd>Lexplore %:p:h<CR>") -- Open netrw
end

vim.keymap.set('x', 'p', '\"_dP') -- Paste without modifying register
vim.keymap.set("n", "<S-Del>", '"_dd') -- Delete line without modifying registers
vim.keymap.set("v", "<S-Del>", '"_D') -- Delete line without modifying registers
vim.keymap.set("n", "<BS>", 'h"_x') -- Delete one character to left
vim.keymap.set("n", "<C-BS>", '"_db') -- Delete one word to left
vim.keymap.set("i", "<C-BS>", '<C-w>') -- Delete one word to left
vim.keymap.set("v", "y", "y`>") -- Yank and jump to end of the yanked text

vim.keymap.set("n", "<A-h>", '"hx2h"hp') -- Move character to left
vim.keymap.set("n", "<A-l>", '"hx"hp') -- Move character to right
vim.keymap.set("v", "<A-h>", '"hd2h"hp`[v`]') -- Move character to left
vim.keymap.set("v", "<A-l>", '"hd"hp`[v`]') -- Move character to right

vim.keymap.set("n", "j", "gj") -- Move cursor down including wrapped lines
vim.keymap.set("n", "k", "gk") -- Move cursor up including wrapped lines

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


vim.keymap.set("n", "<S-Del>", '"_dd') -- Delete line without modifying registers
vim.keymap.set("v", "<S-Del>", '"_D') -- Delete line without modifying registers
vim.keymap.set("n", "<BS>", 'h"_x') -- Delete one character to left
vim.keymap.set("n", "<C-BS>", '"_db') -- Delete one word to left
vim.keymap.set("i", "<C-BS>", '<C-w>') -- Delete one word to left
vim.keymap.set("v", "y", "y`>") -- Yank and jump to end of the yanked text


vim.keymap.set("n", "J", "gJ") -- Join lines without spaces in between

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

vim.keymap.set("v", "<", "<gv") -- Indent left without losing visual selection
vim.keymap.set("v", ">", ">gv") -- Indent right without losing visual selection
vim.keymap.set("v", "<S-TAB>", "<gv") -- Indent right without losing visual selection
vim.keymap.set("v", "<TAB>", ">gv") -- Indent right without losing visual selection
vim.keymap.set("n", "<S-TAB>", "<<") -- Indent right without losing visual selection
vim.keymap.set("n", "<TAB>", ">>") -- Indent right without losing visual selection
vim.keymap.set("n", "<C-a>", "gg^vG$") -- Select all

if vim.g.vscode then
  vim.keymap.set("n", "<leader>rr", [[<Cmd>call VSCodeNotify('editor.action.rename')<CR>]])
  vim.keymap.set("n", "<leader>kc", [[<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>]])
  vim.keymap.set("v", "<leader>kc", [[<Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>]])
  vim.keymap.set("n", "<leader>ee", [[<Cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>]])
end
