" set color scheme
set t_Co=256
colorscheme desert " This will overwrite if installing vim-hybrid succeed

" ----------------------------------------------------------------------
" ------------------------------
" general setting
" ------------------------------
" enable sytax highlight
syntax enable
" display row number
set number
" highlight cursor line
set cursorline
" visualize invisible charactar
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:<
" enable incremental search (move to the match while inputting)
set incsearch
" highlight search results
set hlsearch
" ignore upper/lowercase when search by lowercase. normal search with uppercase
set ignorecase
set smartcase
" wrap for long row
set wrap
" show corresponding ( for ) for 0.1seconds
set showmatch
set matchtime=1
" work over row
set whichwrap=h,l
" not return to the top of the file when searching
set nowrapscan
" enable hidden-buffer (enable edit another file without save)
set hidden
" save 1000 comand history
set history=1000
" same indent as previous row
"set autoindent
"set smartindent " advanced autoindent when making new line
command! -bang -nargs=1 Sw call Sw(<q-args>)
function! Sw(width)
  execute "set shiftwidth=".a:width
  execute "set tabstop=".a:width
endfunction
" use space(4 spaces) instead of tab
set expandtab
set tabstop=4
set shiftwidth=4
" enable backspace for tab and eol, and can use it over the point where starting edit
set backspace=indent,eol,start
" complete by dict
" The default is ".,w,b,u,t,i", which means to scan:
" 	   1. the current buffer
" 	   2. buffers in other windows
" 	   3. other loaded buffers
" 	   4. unloaded buffers
" 	   5. tags
" 	   6. included files
set complete=.,w,b,u,t,i,k
" complete window size
"set pumheight=10
" enable completion in command mode
set wildmenu
" way to split window
set splitbelow
set splitright
" show vertical line at 80
set colorcolumn=80
highlight ColorColumn ctermbg=55

" ----------------------------------------------------------------------
" ------------------------------
" keymapping
" ------------------------------
" cursor move (move cursor as display being)
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j
" erase highlight by escX2
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" disable 'save and quit', 'quit without save'
nnoremap ZZ <nop>
nnoremap ZQ <nop>
" disable Q(chage to EX-mode)
nnoremap Q <nop>
" text-object easier to use
onoremap aa  a>
onoremap ia  i>
onoremap ar  a]
onoremap ir  i]
onoremap ad  a"
onoremap id  i"
" with 'jk' return to Normal-mode
inoremap jk <Esc>
" shortcut for replace
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>

" ----------------------------------------------------------------------
" ------------------------------
" autocommand
" ------------------------------
" avoid to exec autocmd multiple times
augroup vimrc
  autocmd!
augroup END

" for python
"autocmd vimrc FileType python setlocal dictionary+=$HOME/.vim/dict/python.dict
autocmd vimrc FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e

" for c++
"autocmd vimrc FileType cpp setlocal dictionary+=$HOME/.vim/dict/cpp.dict
autocmd vimrc FileType cpp autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd vimrc FileType cpp setlocal shiftwidth=2
autocmd vimrc FileType cpp setlocal tabstop=2
autocmd vimrc FileType cpp setlocal isk-=.

" Make unfortunately needs tabs
autocmd vimrc FileType make setlocal noexpandtab

" ----------------------------------------------------------------------
" ------------------------------
" others
" ------------------------------
" enable fzf
set rtp+=~/.fzf

" set tags file for ctags
set tags=tags;/

" ----------------------------------------------------------------------
" ------------------------------
" plugins
" ------------------------------
" using vim-plug (https://github.com/junegunn/vim-plug)
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.config/nvim/pluged')

Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0ng/vim-hybrid'

call plug#end()

" color scheme
autocmd ColorScheme * highlight Visual cterm=reverse ctermbg=NONE
colorscheme hybrid

" for fzf.vim
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.<q-args>, 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
\ <bang>0)

nnoremap <space>b :Buffers<CR>
nnoremap <expr> <space>g ':Rg ' . expand('<cword>')
nnoremap <space>f :GFiles<CR>
nnoremap <space>t :FZF 
nnoremap <space>] :call fzf#vim#tags(expand('<cword>'))<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)

" for neoterm
let g:neoterm_default_mod = 'botright'

" for rainvow bracket
let g:rainbow_active = 1

" for indent-guides
let g:indent_guides_enable_on_vim_startup = 1
highlight IndentGuidesOdd ctermbg=236
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1

