require("telescope").load_extension("command_center")

local when = function(arg)
    return function()
        if vim.fn.mode() == 'n' then
            vim.cmd(arg.normal)
        else
            vim.cmd(arg.visual)
        end
    end
end

vim.keymap.set("n", '<C-S-p>', "<CMD>Telescope command_center<CR>")
vim.keymap.set("v", '<C-S-p>', "<CMD>Telescope command_center<CR>")

require("command_center").add({
    {
        desc = "Word wrap",
        cmd = "<CMD>set wrap!<CR>",
    },
    --{
    --   desc = "Open selection in GitHub",
    --  cmd = open_visual_in_github,
    --},
    {
        desc = "Open project in GitHub",
        cmd = "<CMD>OpenGithubProject<CR>",
    },
    {
        desc = "Close all tabs but current",
        cmd = "<CMD>BufferCloseAllButCurrent<CR>",
    },
    {
        desc = "Close all tabs but pinned",
        cmd = "<CMD>BufferCloseAllButPinned<CR>",
    },
    {
        desc = "Pin current tab",
        cmd = "<CMD>BufferLineTogglePin<CR>",
    },
    {
        desc = "Git: Blame current line",
        cmd = "<CMD>Gitsigns blame_line<CR>",
    },
    {
        desc = "Git: Show current file history",
        cmd = "<CMD>LazyGitFilterCurrentFile<CR>",
    },
    {
        desc = "Git: Open LazyGit",
        cmd = "<CMD>LazyGit<CR>",
    },
    {
        desc = "Search help",
        cmd = "<CMD>Telescope help_tags<CR>",
    },
    {
        desc = "Insert symbols",
        cmd = "<CMD>Telescope symbols<CR>",
    },
    -- {
    --     desc = "Toggle diagnostics",
    --     cmd = require 'lsp_lines'.toggle
    -- },
    {
        desc = "Reset debugger",
        cmd = "<CMD>VimspectorReset<CR>"
    },
    {
        desc = "Go to next error",
        cmd = "<CMD>lua vim.diagnostic.goto_next{severity={min=vim.diagnostic."
    },
    {
        desc = "Undo: Toggle Tree",
        cmd = "<CMD>:UndotreeToggle<CR>"
    },
    {
        desc = "Go to next warning",
        cmd = "<CMD>lua vim.diagnostic.goto_next{severity=vim.diagnostic.sever"
    },
    -- ./gitsigns.lua
    {
        desc = "Git: Toggle deleted text",
        cmd = "<CMD>lua require'gitsigns'.toggle_deleted()<CR>",
    },
    {
        desc = "Git: Diff with HEAD",
        cmd = "<CMD>lua require'gitsigns'.diffthis('HEAD')<CR>",
    },
    {
        desc = "Git: Blame current line",
        cmd = "<CMD>lua require'gitsigns'.blame_line{full=true}<CR>",
    },
    -- trouble
    {
        desc = "Diagnostics: View Errors (Workspace)",
        keys = { "n", "<C-\\>e", { noremap = true } },
        cmd = "<CMD>TroubleToggle workspace_diagnostics<CR>",
    },
    {
        desc = "Diagnostics: View Errors (Document)",
        cmd = "<CMD>TroubleToggle document_diagnostics<CR>",
    },
    {
        desc = "Diagnostics: Search Errors",
        cmd = "<CMD>Telescope diagnostics<CR>",
    },
    {
        desc = "Diagnostics: Show details",
        keys = { "n", "<leader>se", { noremap = true } },
        cmd = "<CMD>lua vim.diagnostic.open_float()<CR>",
    },
    {
        desc = "Show outline",
        cmd = "<CMD>Lspsaga outline<CR>",
    },
    {
        desc = "Find: Symbols in Workspace",
        cmd = "<CMD>lua require'telescope.builtin'.lsp_workspace_symbols()<CR>",
    },
    {
        desc = "Find: Symbols in Document",
        cmd = "<CMD>lua require'telescope.builtin'.lsp_document_symbols()<CR>",
    },
    {
        desc = "Packer: Synchronize",
        cmd = "<CMD>PackerSync<CR>",
    },
    {
        desc = "Tmux: Split window with current directory",
        cmd = '<CMD>silent !tmux split-window -c "`pwd`"<CR>',
    },
    {
        desc = 'Sort ascending',
        cmd = "<CMD>lua vim.cmd[[Sort]]<CR>",
    },
    { desc = 'Run the nearest test', cmd = '<CMD>lua require("neotest").run.run()<CR>', },
    { desc = 'Run current file tests', cmd = '<CMD>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', },
    { desc = 'Debug the nearest test', cmd = '<CMD>lua require("neotest").run.run({strategy = "dap"})<CR>', },
    { desc = 'Stop the nearest test', cmd = '<CMD>lua require("neotest").run.stop()<CR>', },
    { desc = 'Attach to the nearest test', cmd = '<CMD>lua require("neotest").run.attach()<CR>', },
    { desc = 'Show test output', cmd = '<CMD>lua require("neotest").output.open()<CR>', },
    { desc = 'Toggle output pannel', cmd = '<CMD>lua require("neotest").output_panel.toggle()<CR>', },
    { desc = 'Toggle tests explorer (summary)', cmd = '<CMD>lua require"neotest".summary.toggle()<CR>', },

    -- {
    --     desc = "Sort descending",
    --     cmd = "<CMD>lua vim.cmd[[Sort!]<CR>]",
    -- },
})
