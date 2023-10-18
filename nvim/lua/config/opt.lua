vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
	vim.opt.number = false
else
	vim.opt.number = true
end

-- ========================== Netrw =============================================
vim.g.netrw_keepdir = 0                   -- Keep the current directory and the browsing directory synced. This helps avoid the move files error.
vim.g.netrw_winsize = 30                  -- 30%.
vim.g.netrw_banner = 1                    -- Show banner, it has contextural info.
vim.g.netrw_localcopydircmd = 'cp -r'     -- Enable recursive copying.
vim.cmd [[hi! link netrwMarkFile Search]] -- Highlight marked as search results for better visibility.
-- ==============================================================================

-- Redirect any command to buffer for better pager experience
vim.cmd [[com -nargs=1 -complete=command Redir :execute "tabnew | pu=execute(\'" . <q-args> . "\') | setl nomodified"]]

vim.g.CutlassOverrideDefaults = 1 -- Enable cutlass

vim.opt.relativenumber = false
vim.opt.autowrite = true           -- Enable auto write
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3           -- Hide * markup for bold and italic
vim.opt.confirm = true             -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true          -- Enable highlighting of the current line
vim.opt.expandtab = false          -- Use tabs
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.laststatus = 0
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.listchars = "eol:↩,tab:→⠀,space:·,nbsp:·,extends:❯,precedes:❮"
vim.opt.mouse = "a"            -- Enable mouse mode
vim.opt.pumblend = 10          -- Popup blend
vim.opt.pumheight = 10         -- Maximum number of entries in a popup
vim.opt.scrolloff = 25         -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true      -- Round indent
vim.opt.shiftwidth = 2         -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.showmode = false       -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8      -- Columns of context
vim.opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true       -- Don't ignore case with capitals
vim.opt.smartindent = true     -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true      -- Put new windows below current
vim.opt.splitright = true      -- Put new windows right of current
vim.opt.tabstop = 8            -- Number of spaces tabs count for
vim.opt.shiftwidth = 8         -- Number of spaces tabs count for
vim.opt.termguicolors = true   -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5                -- Minimum window width
vim.opt.wrap = false                   -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
	vim.opt.shortmess:append({ C = true })
end

vim.g.markdown_recommended_style = 0

-- Highlight yanked text
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])
