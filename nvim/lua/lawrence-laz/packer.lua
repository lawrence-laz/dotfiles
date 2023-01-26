-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
-- Plugins are installed in ~/.local/share/nvim/site/pack
--
-- To load plugin for local development:
-- 1. Comment out packer: use 'author/plugin'
-- 2. Add: vim.opt.runtimepath:append("~/git/plugin")
-- 3. :Telescope reload

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        -- Only required if you have packer configured as `opt`
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        --tag = '0.1.0',
        branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-telescope/telescope-symbols.nvim'

    use { 'folke/tokyonight.nvim',
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
        end

    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-context' -- Also known as sticky scroll
    use 'mbbill/undotree'

    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use 'windwp/nvim-ts-autotag'

    use {
        'sQVe/sort.nvim',

        -- Optional setup for overriding defaults.
        config = function()
            require("sort").setup({
                -- Input configuration here.
                -- Refer to the configuration section below for options.
            })
        end
    }


    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                position = "bottom", -- position of the list can be: bottom, top, left, right
                height = 10, -- height of the trouble list when position is top or bottom
                width = 50, -- width of the list when position is left or right
                icons = true, -- use devicons for filenames
                mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
                fold_open = "", -- icon used for open folds
                fold_closed = "", -- icon used for closed folds
                group = true, -- group results by file
                padding = true, -- add an extra new line on top of the list
                action_keys = { -- key mappings for actions in the trouble list
                    -- map to {} to remove a mapping, for example:
                    -- close = {},
                    close = "q", -- close the list
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    refresh = "r", -- manually refresh
                    jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
                    open_split = { "<c-x>" }, -- open buffer in new split
                    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
                    open_tab = { "<c-t>" }, -- open buffer in new tab
                    jump_close = { "o" }, -- jump to the diagnostic and close the list
                    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
                    toggle_preview = "P", -- toggle auto_preview
                    hover = "K", -- opens a small popup with the full multiline message
                    preview = "p", -- preview the diagnostic location
                    close_folds = { "zM", "zm" }, -- close all folds
                    open_folds = { "zR", "zr" }, -- open all folds
                    toggle_fold = { "zA", "za" }, -- toggle fold of current file
                    previous = "k", -- previous item
                    next = "j" -- next item
                },
                indent_lines = true, -- add an indent guide below the fold icons
                auto_open = false, -- automatically open the list when you have diagnostics
                auto_close = false, -- automatically close the list when you have no diagnostics
                auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
                auto_fold = false, -- automatically fold a file trouble list at creation
                auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "﫠"
                },
                use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
            }
        end
    }

    use 'RRethy/vim-illuminate'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    -- Tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'petertriho/nvim-scrollbar'
    use 'stevearc/dressing.nvim'

    use {
        "FeiyouG/command_center.nvim",
        requires = { "nvim-telescope/telescope.nvim" }
    }

    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    use 'mg979/vim-visual-multi'
    use 'christoomey/vim-tmux-navigator'

    use {
        "glepnir/lspsaga.nvim",
        branch = "main",
    }

    use 'ray-x/lsp_signature.nvim'
    use 'tpope/vim-repeat'
    use 'kdheepak/lazygit.nvim'
    use 'tpope/vim-surround'
    use 'rlane/pounce.nvim'
    use 'numToStr/Comment.nvim'

    use 'windwp/nvim-autopairs'
    use 'renerocksai/telekasten.nvim'

    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use 'nvim-telescope/telescope-dap.nvim'
    use 'rcarriga/cmp-dap'

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "Issafalcon/neotest-dotnet",
        }
    }

    -- use 'Issafalcon/neotest-dotnet'
    vim.opt.runtimepath:append("~/git/neotest-dotnet")

    use 'gbprod/cutlass.nvim'
    use 'nvim-pack/nvim-spectre'
    use 'j-hui/fidget.nvim'
    use 'tyru/open-browser-github.vim'
    use 'tyru/open-browser.vim'
    use 'rafcamlet/nvim-luapad'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
