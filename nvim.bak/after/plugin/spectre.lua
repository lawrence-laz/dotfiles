-- Find and replace plugin
require('spectre').setup()

vim.keymap.set('n', '<leader>S', require 'spectre'.open)
vim.keymap.set('n', '<leader>sw', function() require 'spectre'.open_visual({ select_word = true }) end)
vim.keymap.set('v', '<leader>s', '<esc>:lua require("spectre").open_visual()<CR>')
vim.keymap.set('n', '<leader>sp', require 'spectre'.open_file_search)
