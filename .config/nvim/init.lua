vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
require 'impatient'
local g = vim.g
local cmd = vim.cmd
local o, wo, bo = vim.o, vim.wo, vim.bo
local utils = require 'utils'
local opt = utils.opt
local autocmd = utils.autocmd
local map = utils.map

-- Options {{{

-- enable mouse
vim.opt.mouse = 'a'
-- display title
vim.opt.title = true
-- display double width character
-- vim.opt.ambiwidth = 'double'
-- disable swap/backup file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hidden = true
-- use clipboard instead of unnamed
vim.opt.clipboard:append({unnamedplus = true})

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
vim.opt.spelllang = 'en,cjk'
vim.opt.spelloptions = 'camel'

-- fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
autocmd('openfold', {
  'BufReadPost,FileReadPost,BufNew,BufEnter * normal zR',
})


--indent
local tabwidth = 2
-- vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = tabwidth
vim.opt.shiftwidth = tabwidth

-- search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false

-- move
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'
vim.opt.backspace = 'start,eol,indent'

-- }}}


--Key Mapping {{{
vim.g.mapleader = ' '
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
--}}}

-- Language {{{
vim.g.python3_host_prog = '~/.local/share/pyenvs/nvim/.venv/bin/python3'
-- }}}



-- Packer {{{
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! -nargs=* PackerCompile packadd packer.nvim | lua require('plugins').compile(<q-args>)]]
cmd [[command! PackerProfile packadd packer.nvim | lua require('plugins').profile_output()]]
-- require('plugins')
-- }}}

-- Colorscheme
cmd [[colorscheme desert]]

