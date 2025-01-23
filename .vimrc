"Environment
set background=dark
set cmdheight=1
set colorcolumn=80

"hi cursorline guibg=\#333333 "highlight bg colo of current line

"hi clear LineNr
"hi clear
"colorscheme cobalt
colorscheme molokai
hi ColorColumn guibg=#1d1d1d ctermbg=238


" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=8

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

"General
set nocompatible
syntax on
set mouse=a
set autochdir
set noerrorbells
set backspace=indent,eol,start "backspace for dummys
set history=1000
set showcmd
set ruler
"set foldmethod=syntax "or manual, or indent or marker

set hidden

" Indent and Tabs
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set autoindent

"search options
set incsearch
set hlsearch
set ignorecase
set smartcase
" Show partial command you type in the last line of the screen.
set showcmd
" Show the mode you are on the last line.
set showmode
" Show matching words during a search.
set showmatch


" Set up directories
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set viewdir=$HOME/.vim/views//
"" Create directories if they don't exist
silent execute '!mkdir -p $HOME/.vim/backup'
silent execute '!mkdir -p $HOME/.vim/swap'
silent execute '!mkdir -p $HOME/.vim/views'


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

"Map Keys
:map <F2> <Esc>:w<CR>
:map! <F2> <Esc>:w<CR>
"map and make  
:map  <F6> <Esc>:w<CR>;:!make<CR>
:map! <F6> <Esc>:w<CR>;:!make<CR>
:map  <F7> :w<CR>;:!clear;!make<CR>;:!./%<<CR>
:map! <F7> :w<CR>;:!clear;!make<CR>;:!./%<<CR>

:map  <F3> <Esc>:w<CR>;:!clear;!gcc %<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>
:map! <F3> <Esc>:w<CR>;:!clear;!gcc %<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>

:map  <F4> <Esc>:w<CR>:!clear;:!m4 %>%<.s;:!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>
:map! <F4> <Esc>:w<CR>:!clear;:!m4 %>%<.s;:!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!./a.out<CR>


:map  <F5> <Esc>:w<CR>;:!clear;:!m4 %>%<.s;!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!gdb a.out<CR>
:map! <F5> <Esc>:w<CR>;:!clear;:!m4 %>%<.s;!gcc %<.s<CR>;:!echo "***Running***"<CR>;:!gdb a.out<CR>
":map <F5> <Esc>:w<CR> :!clear; gcc -o %< %<CR> :!echo "***Running***"; echo; command time -v "./%<"<CR>
":map! <F5> <Esc>:w<CR> :!clear; gcc -o %< %<CR> :!echo "***Running***"; echo; command time -v "./%<"<CR>

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END

" More Vimscripts code goes here.

""Restore cursor to last position when file was closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" au BufEnter *.c compiler gcc

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.
hi User1 ctermbg=green ctermfg=white guifg=#ffdad8 guibg=#7dcc7d
hi User2 ctermbg=blue ctermfg=white guifg=#ffdad8 guibg=#7dcc7d
hi User3 ctermbg=brown ctermfg=white guifg=#ffdad8 guibg=#7dcc7d
hi User4 ctermbg=darkred ctermfg=white guifg=#ffdad8 guibg=#7dcc7d
hi User5 ctermbg=lightgray ctermfg=white guifg=#ffdad8 guibg=#7dcc7d
hi User6 ctermbg=24 ctermfg=yellow cterm=bold

""" Status Bar
"function! InsertStatuslineColor(mode)
"  if a:mode == 'i'
"    hi statusline guibg=DarkGrey ctermfg=6 guifg=Black ctermbg=0
"  elseif a:mode == 'r'
"    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
"  else
"    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
"  endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" Formats the statusline
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#User6#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%1*
set statusline+=\ B:%n
set statusline+=\ %2*
set statusline+=\ %F    " file name
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
set statusline+=\ %3*
set statusline+=\ %y    "filetype
set statusline+=\ %4*  
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%2*
" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif

" Puts in syntastic warnings
"    if count(g:pathogen_disabled, 'Syntastic') < 1  
"        set statusline+=%#warningmsg#
"        set statusline+=%{SyntasticStatuslineFlag()}
"
"        set statusline+=%*
"    endif

set statusline+=\ %=                        " align left
set statusline+=%1*
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%3*
set statusline+=\ L:%l/%L"[%p%%]            " line X of Y [percent of file]
set statusline+=\ C:%c
set statusline+=\ " current column
"set statusline+=\ Buf:%n                    " Buffer number
set statusline+=%1*
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor

set laststatus=2

" }}}


" Custom Functions ------------------------------------------------------------ {{{

function! FileHeader(...)
  let name = 0 < a:0 ? a:1 : inputdialog("Filename: ")
  let note = 1 < a:0 ? a:2 : inputdialog("Note: ")
  let description = 2 < a:0 ? a:3 : inputdialog("Describe this module: ")
  "let userdate = 3 < a:0 ? a:4 : inputdialog("Date: ")
  let userdate = strftime("%d %b %Y")

  return  "//" . repeat('-', s:width) . "\n" 
  \       . "// | \n" 
  \       . "// Filename    : " . name . "\n"
  \       . "//\n"
  \       . "// Author      :Jason De Boer\n"
  \       . "// ID          :30034428\n"
  \       . "// Date        :". userdate . "\n"
  \       . "//\n"
  \       . "//\n"
  \       . "// Note        : " . note . "\n"
  \       . "// \n"
  \       . "// " . description . "\n"
  \       . "// \n//"
  \       . repeat('-', s:width) . "\n"
  \       . "\n"

endfunction
nmap <silent> --h "=FileHeader()<CR>:0put =<CR>


" }}}
