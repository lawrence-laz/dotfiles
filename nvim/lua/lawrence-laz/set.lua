vim.opt.nu = true -- Show line numbers
vim.opt.relativenumber = false -- Maybe some day

vim.opt.termguicolors = true

vim.opt.listchars='eol:↩,tab:→⠀,space:·,nbsp:·,extends:❯,precedes:❮'
vim.opt.list = false

vim.cmd[[set clipboard^=unnamed,unnamedplus]] -- Use system clipboard
-- Persist clipboard even if nvim is closed
vim.cmd[[
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
]]

vim.cmd'set smartcase'
vim.g.closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.csproj,*.js,*.jsx'
vim.g.tmux_navigator_no_mappings = 1 -- Custom keymaps defined in tmux.lua

vim.env.GIT_EDITOR = "nvim --listen ~/tmp/nvim-server.pipe"

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
vim.opt.signcolumn = 'yes' -- ???
vim.opt.isfname:append("@-@") -- ???

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

