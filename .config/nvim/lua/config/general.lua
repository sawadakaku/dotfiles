-- Set before lazy.nvim loads so that plugin mappings use it
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-------------
-- Options --
-------------
-- Only settings that differ from Neovim's defaults
vim.opt.mouse = 'a'
vim.opt.title = true
-- disable swap/backup file
vim.opt.swapfile = false
vim.opt.backup = false
-- use clipboard instead of unnamed
vim.opt.clipboard:append({"unnamedplus"})

-- appearance
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.listchars = {tab = '>-', trail = '-', nbsp = '%', extends = '>', precedes = '<', eol = '<'}
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spell = true
vim.opt.spelllang = 'en,cjk'
vim.opt.spelloptions = 'camel'
vim.opt.laststatus = 3

--indent
local tabwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = tabwidth
vim.opt.shiftwidth = tabwidth

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false

-- move
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'

-----------------
-- Key Mapping --
-----------------
local map = vim.keymap.set
map({'n', 'v'}, 'k', 'gk')
map({'n', 'v'}, 'j', 'gj')
map({'n', 'v'}, '<C-p>', '5gk')
map({'n', 'v'}, '<C-n>', '5gj')
map('n', 'ZZ', '<nop>')
map('n', 'ZQ', '<nop>')
map('n', 'Q', '<nop>')
map('n', '<Esc><Esc>', ':<C-u>nohlsearch<CR>')
map('i', 'jk', '<Esc>')
map('n', 'gs', ':<C-u>%s///g<Left><Left><Left>')
map('v', 'gs', ':s///g<Left><Left><Left>')
map('n', '<C-w>z', '<C-w>|<C-w><C-_>')
map('n', '<F3>', ':set spell!<CR>')
