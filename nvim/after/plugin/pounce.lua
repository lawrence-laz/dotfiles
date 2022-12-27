require 'pounce'.setup {
    accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
    accept_best_key = "<enter>",
    multi_window = true,
    debug = false,
}

vim.cmd [[hi PounceMatch guibg=peru guifg=wheat]]

vim.keymap.set("n", "s", "<cmd>Pounce<CR>") -- Go to fuzzy search result
vim.keymap.set("v", "s", "<cmd>Pounce<CR>") -- Go to fuzzy search result
