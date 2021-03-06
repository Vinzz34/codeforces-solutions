set nu 
filetype plugin indent on
syntax on
set hidden
set backspace=indent,eol,start
set noswapfile
set autoindent
set smartindent
set nowrap

if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'crusoexia/vim-monokai'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'tomasr/molokai'
call plug#end()

colorscheme monokai

