vim.keymap.set("n", "<C-p>", function()
	require("telescope.builtin").find_files({ hidden = true })
end) -- Find file by name
vim.keymap.set("n", "<C-S-f>", require("telescope.builtin").live_grep) -- Find file contents globally
vim.keymap.set("v", "<C-S-f>", function()
	local selection = vim.get_visual_selection()
	require("telescope.builtin").live_grep({ default_text = selection })
end) -- Find file contents globally
vim.keymap.set("n", "<C-f>", require("telescope.builtin").current_buffer_fuzzy_find) -- Find in current file's content
vim.keymap.set("v", "<C-f>", function()
    local selection = vim.get_visual_selection()
	require("telescope.builtin").current_buffer_fuzzy_find({default_text = selection})
end) -- Find in current file's content
vim.keymap.set("n", "<S-F12>", require("telescope.builtin").lsp_references) -- Find references of symbol under cursor
vim.keymap.set("n", "<leader>gu", require("telescope.builtin").lsp_references) -- Find references of symbol under cursor
vim.keymap.set("n", "<leader>gd", require("telescope.builtin").lsp_definitions) -- Find definitions of symbol under cursor
vim.keymap.set("n", "<F12>", require("telescope.builtin").lsp_definitions) -- Find definitions of symbol under cursor
vim.keymap.set("n", "<C-F12>", require("telescope.builtin").lsp_implementations) -- Find implementations of symbol under cursor
vim.keymap.set("n", "<C-,>", require("telescope.builtin").lsp_dynamic_workspace_symbols) -- Find symbols globally
vim.keymap.set("n", "<C-S-t>", require("telescope.builtin").oldfiles) -- Closed files
