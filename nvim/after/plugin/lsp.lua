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
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'buffer', keyword_length = 3 },
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
    vim.keymap.set("n", "<leader>sr", require'telescope.builtin'.lsp_references) -- [s]how [r]eferences
    vim.keymap.set("n", "<S-F12>", require'telescope.builtin'.lsp_references) -- [s]how [r]eferences (VS like)
    vim.keymap.set("n", "<leader>st", "<cmd>NvimTreeToggle<CR>") -- [s]how [t]ree
    vim.keymap.set("n", "<C-A-l>", "<cmd>NvimTreeToggle<CR>") -- [s]how [t]ree (VS like)
    vim.keymap.set("n", "<leader>ss", require'telescope.builtin'.lsp_document_symbols) -- [s]how [s]ymbols
    vim.keymap.set("n", "<leader>sc", "<cmd>Telescope command_palette<cr>") -- [s]how [c]ommand palette
    vim.keymap.set("n", "<C-S-p>", "<cmd>Telescope command_palette<cr>") -- [s]how [c]ommand palette (VS like)
    vim.keymap.set("n", "<leader>sm", vim.lsp.buf.signature_help) -- [s]how [m]ethod signature (VS like)
    vim.keymap.set("n", "<C-S-Space>", vim.lsp.buf.signature_help) -- [s]how [m]ethod signature (VS like)

    -------------------------- "Go to" mappings
    vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next) -- [g]o to next [e]rror
    vim.keymap.set("n", "<C-S-F12>", vim.diagnostic.goto_next) -- [g]o to next [e]rror (VS like)
    vim.keymap.set("n", "<leader>gE", vim.diagnostic.goto_prev) -- [g]o to previous [E]rror
    vim.keymap.set("n", "<leader>gd", require'telescope.builtin'.lsp_definitions) -- [g]o to [d]efinition
    vim.keymap.set("n", "<F12>", require'telescope.builtin'.lsp_definitions) -- [g]o to [d]efinition (VS like)
    vim.keymap.set("n", "<leader>gi", require'telescope.builtin'.lsp_implementations) -- [g]o to [i]mplementation
    vim.keymap.set("n", "<C-F12>", require'telescope.builtin'.lsp_implementations) -- [g]o to [i]mplementation (VS like)
end)

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
