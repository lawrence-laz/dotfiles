vim.opt.nu = true -- Show line numbers
vim.opt.relativenumber = false -- Maybe some day

vim.opt.termguicolors = true

vim.opt.listchars = "eol:↩,tab:→⠀,space:·,nbsp:·,extends:❯,precedes:❮"
vim.opt.list = false

vim.cmd([[set clipboard^=unnamed,unnamedplus]]) -- Use system clipboard
-- Persist clipboard even if nvim is closed
vim.cmd([[
let g:clipboard = {
  \   'name': 'xclip',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }
]])

vim.g.CutlassOverrideDefaults = 1 -- Enable cutlass

vim.g.closetag_filenames = "*.xml,*.html,*.xhtml,*.phtml,*.csproj,*.js,*.jsx"
vim.g.tmux_navigator_no_mappings = 1 -- Custom keymaps defined in tmux.lua

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.cmd([[set fillchars+=foldopen:▾,foldsep:│,foldclose:▸]])
vim.opt.foldcolumn = "0" -- Use 'auto' to display arrows, but it also shows ugly numbers

-- Disable vim-visual-multi's <C-n> mapping
vim.cmd([[let g:VM_maps = {}]])
vim.cmd([[let g:VM_maps['Find Under'] = '']])

vim.env.GIT_EDITOR = "nvim --listen ~/tmp/nvim-server.pipe"

vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false -- Do not highlight search results
vim.opt.incsearch = true -- Search incrementally

vim.opt.scrolloff = 100 -- Keep cursor centered
vim.opt.signcolumn = "yes" -- ???
vim.opt.isfname:append("@-@") -- ???

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Don't create new comment on enter?
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Highlight yanked text
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

vim.o.cursorline = true -- Show current cursor line
