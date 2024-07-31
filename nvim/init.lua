require 'utils.global'

-- Bootstrap package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Initialize package manager
-- and load ./lua/plugins/init.lua
-- root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
-- When loading plugins, if opts = {} is specified, this makes lazy call the setup function with default options.
-- config is a function that gets called after the plugin is loaded.
require('lazy').setup(
    'plugins',
    {
        dev = {
            -- This is where lazy.nvim will look for a packages when dev=true on package options.
            path = "~/git",
        }
    })

-- Load configuration
require('config')

--[[
Min repro configuration:
```lua
for name, url in pairs{
  -- ADD PLUGINS _NECESSARY_ TO REPRODUCE THE ISSUE, e.g:
  -- some_plugin = 'https://github.com/author/plugin.nvim'
} do
  local install_path = vim.fn.fnamemodify('nvim_issue/'..name, ':p')
  if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system { 'git', 'clone', '--depth=1', url, install_path }
  end
  vim.opt.runtimepath:append(install_path)
end

-- ADD INIT.LUA SETTINGS THAT IS _NECESSARY_ FOR REPRODUCING THE ISSUE
```

Run: nvim --clean -u my_issue.lua
--]]

--[[
Profile, debug slowness
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!
--]]
