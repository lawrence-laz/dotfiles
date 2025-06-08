return {
    'kevinhwang91/nvim-ufo',
    enabled = true,
    dependencies = { 'kevinhwang91/promise-async' },
    config = function(_, opts)
        vim.o.foldcolumn = '0' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        -- mapped in mycommands

        -- Option 3: treesitter as a main provider instead
        -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
        -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
        --
        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })

        vim.cmd [[hi default link UfoPreviewSbar PmenuSbar]]
        vim.cmd [[hi default link UfoPreviewThumb PmenuThumb]]
        vim.cmd [[hi default link UfoPreviewWinBar UfoFoldedBg]]
        vim.cmd [[hi default link UfoPreviewCursorLine Visual]]
        vim.cmd [[hi default link UfoFoldedEllipsis Comment]]
        vim.cmd [[hi default link UfoCursorFoldedLine CursorLine]]


        -- Auto close folds on open
        -- BUG: Triggered on `gF` which is annoying.
        -- vim.api.nvim_create_autocmd('BufRead', {
        --     callback = function()
        --         vim.cmd [[ silent! foldclose! ]]
        --         local bufnr = vim.api.nvim_get_current_buf()
        --         -- make sure buffer is attached
        --         vim.wait(100, function() require 'ufo'.attach(bufnr) end)
        --         if require 'ufo'.hasAttached(bufnr) then
        --             local winid = vim.api.nvim_get_current_win()
        --             local method = vim.wo[winid].foldmethod
        --             if method == 'diff' or method == 'marker' then
        --                 require 'ufo'.closeAllFolds()
        --                 return
        --             end
        --             -- getFolds returns a Promise if providerName == 'lsp', use vim.wait in this case
        --             local ok, ranges = pcall(require 'ufo'.getFolds, bufnr, 'treesitter')
        --             if ok and ranges then
        --                 if require 'ufo'.applyFolds(bufnr, ranges) then
        --                     require 'ufo'.closeAllFolds()
        --                 end
        --             end
        --         end
        --     end
        -- })
    end
}
