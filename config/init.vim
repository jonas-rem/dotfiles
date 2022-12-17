" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'nvie/vim-flake8'
Plug 'mfussenegger/nvim-lint'
Plug 'Deedone/checkpatch.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
set mouse=a

"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+\%#\@<!$/
"highlight ExtraTab ctermbg=darkgreen guibg=darkgreen

" Show trailing whitespace:
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" Show trailing whitespace and spaces before a tab:
"match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show trailing tabs:
"match ExtraTab /\s\[^\t]/

" Show tabs that are not at the start of a line:
"match ExtraWhitespace /[^\t]\zs\t\+/

" Show spaces used for indenting (so you use only tabs for indenting).
"match ExtraWhitespace /^\t*\zs \+/
"
set colorcolumn=80
highlight ColorColumn ctermbg=black

set number
set autoindent
set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab 
set nosmarttab
set nojoinspaces
set list
set listchars=tab:▶\ ,trail:◥,extends:>,precedes:<,space:⋅

set termguicolors

" colorscheme
syntax on
set background=dark
set t_Co=256
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

" statusline
set laststatus=2
set noshowmode
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline_left_sep=''
let g:airline_right_sep=''

if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
let g:airline_symbols.linenr=''
let g:airline_symbols.paste=''
let g:airline_symbols.crypt=''
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.branch=''
let g:airline_symbols.spell=''
let g:airline_symbols.notexists=''
let g:airline_symbols.whitespace=''
let g:airline_section_z='%3l/%L : %2v'

let g:checkpatch_enabled=1
let g:checkpatch_path="/home/jonas/git/zephyrproject/zephyr/scripts/checkpatch.pl"

"require('lint').linters_by_ft = {
"  python = {'flake8',}
"}
"au BufWritePost lua require('lint').try_lint()

"autocmd BufWritePost *.py call Flake8()
"autocmd BufWritePost,BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
