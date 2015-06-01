"256色利用
set term=xterm-256color
set t_Co=256

syntax on
colorscheme molokai
"highlight Normal ctermbg=none
"highlight LineNr ctermbg=none
"highlight NonText ctermbg=none
highlight Normal ctermbg=232  "transparent
highlight LineNr ctermbg=232  "transparent
highlight NonText ctermbg=232  "transparent

set fileencoding=japan
set fileencodings=utf-8,euc-jp,iso-2022-jp,ucs-2le,ucs-2,cp932
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

set laststatus=2

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
