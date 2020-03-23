"set nocompatible        "either make vim more vi-compatible or more useful
syntax on
set expandtab           "insert 4 whitespace on tab"
set tabstop=4           "set 1 tab as 4 whitespaces"
set shiftwidth=4        "< and > adds 4 whitespaces"
set softtabstop=4       "removes 4 whitespaces on backspace"
set smartindent         "keeps indention on return"
set background=dark     "vim tries to use colors that look good on dark background"
colorscheme solarized
let g:solarized_termtrans=1
let g:airline_theme="luna"
let g:airline_powerline_fonts = 1
set autochdir           "auto changes working directory to current tab"
set number              "enables line numbers"
set relativenumber      "shows relative numbers of lines that isn't containing the cursor"cI
set ignorecase          "ignoring case of search pattern"
set smartcase           "if case is given it will look for it"
set hlsearch            "highlighting search"
set incsearch           "increasing search while typing"
set scrolloff=7         "sets the line where to begin scrolling
set wildmenu            "shows suggestions for commandline "
set cursorline          "highlights current line"
set cursorcolumn        "highlights current column
set colorcolumn=4,80    "set horizontal ruler
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" set highlighting color"
highlight colorcolumn ctermbg=0
set showtabline=2
set showcmd             "show key input while its inputted"
set laststatus=2        "always shows statusline
set statusline=     " clear statusline
set stl+=%F         " add fullpath
set stl+=\ %y       " add recognized filetype
set stl+=\ %m       " add modified flag
set stl+=\ Reg-\":\ %{strpart(@\",0,20)}       " add Register-" content
"set stl+=\ Reg-\.:\ %{strpart(@\.,0,20)}       " add Register-. content
set stl+=%=\ Buffer:\ %n\ Line:\ %l/%L\ Column:\ %c  " add column and row numbers
set stl+=%=\ 0x%02B " add ascii value of char
hi StatusLine ctermbg=0 ctermfg=253
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
filetype on
filetype plugin indent on " loads plugin/indent file for filetype
"set cmdheight=2"
cmap w!! w !sudo tee > /dev/null % 
"sets the corresponding closing bracket"
inoremap {      {}<Left>
inoremap (      ()<Left>
inoremap "      ""<Left>
inoremap '      ''<Left>
"remappings
"insert blank line with enter without entering insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
"execute script in the shell
nnoremap <F9> :!%:p<CR>
