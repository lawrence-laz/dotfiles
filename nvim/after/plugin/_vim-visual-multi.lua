-- https://github.com/mg979/vim-visual-multi/blob/e522dd192eb19d060a8bc312fb51fe4af49aadb1/autoload/vm/plugs.vim
vim.keymap.set("n", "<A-S-;>", "<Plug>(VM-Select-All)") -- Select all occurances of current word
vim.keymap.set("v", "<A-S-;>", "<Plug>(VM-Visual-All)") -- Select all occurances of current word
vim.keymap.set("n", "<A-S-j>", "<Plug>(VM-Add-Cursor-Down)") -- Create cursor below
vim.keymap.set("n", "<A-S-k>", "<Plug>(VM-Add-Cursor-Up)") -- Create cursor above
vim.keymap.set("n", "<A-LeftMouse>", "<Plug>(VM-Mouse-Cursor)") -- Create at mouse position

