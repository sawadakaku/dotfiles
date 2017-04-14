" ----------------------------------------------------------------------
" MUST BE WRITTEN AT THE TOP OF FILE
" use vim as not vi compatible mode (should write at top of .vimrc)
set nocompatible
" ----------------------------------------------------------------------

" set color scheme
set t_Co=256
colorscheme desert

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
" never wrap for long row
set nowrap
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
set autoindent
"set smartindent " advanced autoindent when making new line
set shiftwidth=2
" use space(2 spaces) instead of tab
set expandtab
set tabstop=2
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
set complete+=k
" complete window size
"set pumheight=10
" ----------------------------------------------------------------------
" ------------------------------
" keymapping
" ------------------------------
" save file, close window
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>Q :<C-u>q!<CR>
" cursor move (move cursor as display being)
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j
" insert blank line whithout changing to INSERT mode
nnoremap <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
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
" for python
autocmd FileType python :set dictionary+=$HOME/.vim/dict/python.dict
" for c++
autocmd FileType cpp :set dictionary+=$HOME/.vim/dict/cpp.dict
