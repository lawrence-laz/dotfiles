
vim.keymap.set('n', '<C-p>', require'telescope.builtin'.find_files) -- Find file by name
vim.keymap.set('n', '<C-S-f>', require'telescope.builtin'.live_grep) -- Find file contents globally
vim.keymap.set('n', '<C-f>', require'telescope.builtin'.current_buffer_fuzzy_find) -- Find in current file's content
vim.keymap.set('n', '<S-F12>', require'telescope.builtin'.lsp_references) -- Find references of symbol under cursor
vim.keymap.set('n', '<F12>', require'telescope.builtin'.lsp_definitions) -- Find definitions of symbol under cursor
vim.keymap.set('n', '<C-F12>', require'telescope.builtin'.lsp_implementations) -- Find implementations of symbol under cursor
vim.keymap.set('n', '<C-,>', require'telescope.builtin'.lsp_workspace_symbols) -- Find symbols globally

