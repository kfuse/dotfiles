"256色利用
set term=xterm-256color
set t_Co=256

syntax on
colorscheme molokai
highlight Normal ctermbg=none
highlight LineNr ctermbg=none
"highlight Normal ctermbg=234  "transparent
"highlight LineNr ctermbg=234  "transparent

set fileencoding=japan
set fileencodings=utf-8,euc-jp,iso-2022-jp,ucs-2le,ucs-2,cp932
"set encoding=japan
set number
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set nrformats="
set hlsearch
set splitright
set splitbelow

set list
set listchars=tab:>-,trail:_,extends:\

"set statusline=%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
"set statusline+=\ %=                    " align left
"set statusline+=\ %b\ 0x%B\ %l/%L,%c    " ASCII and byte code, line x of y, colymn
set laststatus=2

"set term=builtin_linux
"set ttytype=builtin_linux

"highlight SpecialKey ctermfg=12
highlight ZenkakuSpace cterm=underline ctermfg=Magenta guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" Escキー2回タイプしてハイライトを解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" gfでファイルを別タブで開く（別ウィンドウは<c-w>f）
nnoremap gf <c-w>gf

" <Tab>で画面切り替えできようにする
nnoremap <Tab> <C-w>w

" ビジュアルモードで選択しているワードをサーチ
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>N

" 入力モードに応じてステータス ラインの色を変える
"if v:version >= 700
"  augroup InsertHook
"  autocmd!
"  autocmd InsertEnter * highlight StatusLine ctermfg=24 ctermbg=7
"  autocmd InsertLeave * highlight StatusLine ctermfg=238 ctermbg=7
"  augroup END
"endif

" 日本語を扱うために必要
"set encoding=japan

" ファイルの漢字コード自動判別のために必要。(要iconv)
"if has('iconv')
"  set fileencodings&
"  set fileencodings+=ucs-2le,ucs-2
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
"  "iconvがJISX0213に対応しているかをチェック
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213,euc-jp'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
"  "fileencodingsを構築
"  let &fileencodings = &fileencodings.','.s:enc_jis.',utf-8'
"  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
"    set fileencodings+=cp932
"    let &encoding = s:enc_euc
"  else
"    let &fileencodings = &fileencodings.','.s:enc_euc
"  endif
"  "定数を処分
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif

" タブで補完
function! CleverTab()
    if strpart( getline('.'), 0, col('.') - 1 ) =~ '^\s*$'
        echo "Tab"
        return "\<Tab>"
    else
       return "\<C-N>"
    endif
endfunction

inoremap <Tab> <C-R>=CleverTab()<cr>

" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive'
      \ }
      \ }

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction
