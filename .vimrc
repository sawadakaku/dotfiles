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
set autoindent
"set smartindent " advanced autoindent when making new line
set shiftwidth=4
" use space(2 spaces) instead of tab
set expandtab
set tabstop=4
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
" enable completion in command mode
set wildmenu
" way to split window
set splitbelow
set splitright
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
" avoid to exec autocmd multiple times
augroup vimrc
  autocmd!
augroup END
" for python
autocmd vimrc FileType python :setlocal dictionary+=$HOME/.vim/dict/python.dict
" for c++
autocmd vimrc FileType cpp :setlocal dictionary+=$HOME/.vim/dict/cpp.dict
autocmd vimrc FileType cpp setlocal shiftwidth=2
autocmd vimrc FileType cpp setlocal tabstop=2

" ----------------------------------------------------------------------
" ------------------------------
" plugin
" ------------------------------
" ------------------------------
" for dein
" ------------------------------
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Townk/vim-autoclose')
  call dein#add('nvie/vim-flake8',{'on_ft' : 'python'})
  call dein#add('davidhalter/jedi-vim',{'on_ft' : 'python'})
"  call dein#add('Shougo/vimproc.vim', {
"          \ 'build': {
"          \     'mac': 'make -f make_mac.mak',
"          \     'linux': 'make',
"          \     'unix': 'gmake',
"          \    },
"          \ })
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('thinca/vim-quickrun')


  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" ------------------------------
" for neocomplete
" ------------------------------
" enable auto complete
let g:neocomplete#enable_at_startup = 1

" ------------------------------
" for flake8
" ------------------------------
" run flake8 when save buffer
autocmd BufWritePost *.py call Flake8()

" ------------------------------
" for QuickRun
" ------------------------------
" 出力先
" 成功した場合：quickrun 専用の出力バッファ
" 失敗した場合：quickfix を :copen で開く
" バッファの開き方：botright 8sp
"
" コマンドの実行は vimproc.vim を使用する
" runner に vimproc を設定
" runner/vimproc/updatetime には更新するタイミングを設定
" この値が大きいとコンパイルが終了していても
" 結果が出力されるまでに時間がかかる可能性がある。
"
" cpp.type にて使用するコンパイラなどを設定する
" cpp.cmdopt にコマンドラインオプションを設定
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "error",
\       "outputter/error/success" : "buffer",
\       "outputter/error/error"   : "quickfix",
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/quickfix/open_cmd" : "copen",
\   },
\   "cpp" : {
\       "type" : "cpp/clang++",
\       "cmdopt" : "-std=c++14"
\   },
\   "python" : {
\       "type" : "python",
\       "command" : "python3"
\   },
\}
"\       "runner" : "vimproc",
"\       "runner/vimproc/updatetime" : 500,
" :QuickRun 時に quickfix の中身をクリアする
" こうしておかないと quickfix の中身が残ったままになってしまうため
let s:hook = {
\   "name" : "clear_quickfix",
\   "kind" : "hook",
\}

function! s:hook.on_normalized(session, context)
  call setqflist([])
endfunction

call quickrun#module#register(s:hook, 1)
unlet s:hook

" stop quickrun <C-c>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" ------------------------------
" for neosnippet
" ------------------------------
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets/'

