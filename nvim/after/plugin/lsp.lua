local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.set_preferences({
})

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
    'bashls',
    --'cpplint',
    --'cpptools',
    --'csharpier',
    --'cspell',
    'cssls',
    --'dockerfile-language-server',
    --'json-lsp',
    --'jsonlint',
    --'markdownlint',
    'omnisharp',
    'pyright',
    'vimls',
    'lemminx',
    'yamlls',
    'html',
})

local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer', keyword_length = 1 },
    }
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = { diagnostics = { globals = { 'vim' } } } -- Stop undefined 'vim' warnings
    }
})


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)
    -- vim.lsp.buf.hover
    -- vim.lsp.buf.workspace_symbol
    -- vim.diagnostic.open_float
    -- vim.diagnostic.goto_next
    -- vim.lsp.buf.code_action
    -- vim.lsp.buf.references
    -- vim.lsp.buf.rename
    -- vim.lsp.buf.signature_help
    -------------------------- "Show" mappings
    vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float) -- [s]how [e]rror
    vim.keymap.set("n", "<leader>sE", vim.diagnostic.setloclist) -- [s]how all [E]rrors in file  alternative is telescope_builtin.diagnostics
    vim.keymap.set("n", "<leader>sm", vim.lsp.buf.signature_help) -- [s]how [m]ethod signature (VS like)
    vim.keymap.set("n", "<C-S-Space>", vim.lsp.buf.hover) -- [s]how [m]ethod signature (VS like)

    -------------------------- "Go to" mappings
    vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next) -- [g]o to next [e]rror
    vim.keymap.set("n", "<C-S-F12>", function() -- Go to next error/warning/info/hint
        if vim.diagnostic.get_next { severity = vim.diagnostic.severity.ERROR } then
            vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
        elseif vim.diagnostic.get_next { severity = vim.diagnostic.severity.WARN } then
            vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN }
        elseif vim.diagnostic.get_next { severity = vim.diagnostic.severity.INFO } then
            vim.diagnostic.goto_next { severity = vim.diagnostic.severity.INFO }
        elseif vim.diagnostic.get_next { severity = vim.diagnostic.severity.HINT } then
            vim.diagnostic.goto_next { severity = vim.diagnostic.severity.HINT }
        end
    end)
end)

vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action)
vim.keymap.set("v", "<C-.>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename) -- [c]ode [r]ename (VS like)
vim.keymap.set("n", "<leader>kd", vim.lsp.buf.format) -- [c]ode [f]ormat (VS like)
--vim.keymap.set("n", "<leader>kc", function() require'Comment.api'.toggle.linewise() end) -- Comment toggle (VS like)
--vim.keymap.set('x', '<leader>kc', function() -- Comment toggle (VS like)
--vim.api.nvim_feedkeys('<ESC>', 'nx', false)
--require'Comment.api'.toggle.linewise(vim.fn.visualmode())
--end)
--vim.keymap.set('v', '<leader>kc', "<Plug>(comment_toggle_linewise)")


vim.opt.signcolumn = 'yes' -- Keep sign column always visible

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = true,
})
