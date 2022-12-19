vim.g.mapleader = ' ' -- Key for <leader>

vim.keymap.set('n', '<C-A-l>', vim.cmd.Ex) -- Open file explorer

vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv") -- Move selection down
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv") -- Move selection up
vim.keymap.set('n', '<A-j>', "V:m '>+1<CR>gv=gv<ESC>") -- Move current line down
vim.keymap.set('n', '<A-k>', "V:m '<-2<CR>gv=gv<ESC>") -- Move current line up

vim.keymap.set('n', 'j', "gj") -- Move cursor down including wrapped lines
vim.keymap.set('n', 'k', "gk") -- Move cursor up including wrapped lines


vim.keymap.set("n", "<C-->", "<C-O>") -- Go back
vim.keymap.set("n", "<C-_>", "<C-I>") -- Go forward

vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>") -- Search selection in visual mode
vim.keymap.set("v", "<C-Enter>", "gx") -- Open selection with default app

vim.keymap.set('n', 'Q', '<nop>') -- ???


vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = {"*.lua"},
    command = 'source',
})
vim.keymap.set('n', 'J', 'gJ') -- Join lines without spaces in between
--vim.keymap.set('n', 'c', '_c') -- Change text without modifying registers
vim.keymap.set('x', 'p', '\"_dP') -- Paste without modifying register

