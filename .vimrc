" Vim
set nocompatible                " No compatible to Vi editor. Vim is useful.

" Appearance
colorscheme torte
set ruler                       " Show the line and column number of the cursor position, separated by a comma.
set number                      " Print the line number in front of each line.
set showcmd                     " Show (partial) command in the last line of the screen.
set hlsearch                    " When there is a previous search pattern, highlight all its matches.
set incsearch                   " While typing a search command, show where the pattern matches.
set laststatus=2                " Always show the status line.
set t_Co=256                    " Support 256 colors

" Tab & Indentation
set cindent                     " A tab in front of a line inserts blanks according to 'shiftwidth'.
set expandtab                   " In insert mode, use the appropriate number of spaces to insert a tab .
set tabstop=4                   " Number of spaces that a tab in the file counts for.
set shiftwidth=4                " Number of spaces to use for (auto) indentation.
set smartindent                 " Do an auto indentation when starting a new line.

" Useful Setting
syntax on
set nowrap                      " Lines will not wrap and only part of long lines will be displayed.
set mouse=a                     " Enable the use of mouse in all modes.
set history=100                 " A history of ':' commands, and a history of previous search patterns are remembered.
set scrolloff=5                 " Minimal number of screen lines to keep above and below the cursor.
set encoding=utf8               " Sets the character encoding used inside Vim.
set backspace=indent,eol,start  " Allow backspacing over indentation, line breaks(join lines) and starting of insert
set timeoutlen=1000 ttimeoutlen=0


" Key Mapping
" basic mapping
nnoremap <S-j> :bp<CR>
nnoremap <S-k> :bn<CR>
nnoremap <C-a> ggVG
nnoremap <C-s> :w<CR>
nnoremap <C-q> :wqa<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <C-c> :y+<CR>
" autoclose braces
inoremap { {}<Esc>ha
" autorun mapping
nnoremap <F5>   :silent call AutoRun()<CR>
nnoremap <F6>   :silent call Run()<CR>
nnoremap <F7>   <C-w>o
nnoremap <F8>   :silent call Run_with_time()<CR>
inoremap <F5>   <Esc>:silent call AutoRun()<CR>
inoremap <F6>   <Esc>:silent call Run()<CR>
inoremap <F7>   <Esc><C-w>o
inoremap <F8>   :silent call Run_with_time()<CR>


" Abbreviate
abbreviate pii pair<int, int>


" Running setting
autocmd BufNewFile *.cpp 0r ~/cpp_template.cpp
set makeprg=g++\ %\ -o\ %<\ -Wall\ -std=c++14\ -O2


" function
function Set()
    if winnr('$')>1
        wincmd l
        wincmd k
        write
        wincmd t
        only
    endif
    write
endfunc

function Run()
    call Set()
    " !(time ./%< <%<.in >%<.out)2>>%<.out
    !(./%< <%<.in >%<.out)2>>%<.out
    belowright vsplit %<.in
    belowright sview %<.out
    wincmd t
    redraw!
endfunc

function Run_with_time()
    call Set()
    !(time ./%< <%<.in >%<.out)2>>%<.out
    belowright vsplit %<.in
    belowright sview %<.out
    wincmd t
    redraw!
endfunc

function AutoRun()
    call Set()
    let v:statusmsg=''
    make
    if empty(v:statusmsg)
        call Run()
    else
        cwindow
        winc t
        redraw!
    endif
endfunc

