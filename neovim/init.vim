" To reload vimrc:
" :so $MYVIMRC

" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  " Ensure all needed directories exist
  call system('mkdir -p ~/.config/nvim/plugins')

  " Download the actual plugin manager
  call system('\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

  " Install plugins
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.config/nvim/plugins')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }    " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                              " Fuzzy file finder
Plug 'https://github.com/tpope/vim-fugitive'                         " Git wrapper
Plug 'https://github.com/w0rp/ale'                                   " Async linter

" TODO do something special to auto load this stuff
Plug 'https://github.com/jelera/vim-javascript-syntax', { 'for': 'javascript' }
call plug#end()

" UI settings
syntax on                       " Enable syntax highlighting
set number                      " Show line numbers
call load_colorscheme#Load()    " Load colorscheme

set textwidth=80                " Autowrap text that goes beyond indicated limit
set colorcolumn=+1              " Show textwidth limit bar
highlight ColorColumn ctermbg=8 " Set the textwidth limit bar to be dark gray

set cursorline                  " Highlight currently focused line

set expandtab                   " Use spaces instead of tabs
set tabstop=2                   " Indicates how many spaces in a tab
set shiftwidth=2                " Indicates number of spaces for autoindent

" Other settings
set mouse=a    " Add mouse support

set ignorecase " Enable case insensitive search
set smartcase  " If you search with upper cases, search becomes case sensitive

set splitbelow " When doing :split, split screen to below
set splitright " When doing :vsplit, split screen to the right

autocmd BufWritePre * :%s/\s\+$//e " Automatically remove trailing spaces

" Map jj to esc when in insert mode
inoremap jj <Esc>

" For git commit messages, set a specific line width
autocmd FileType gitcommit set textwidth=72
" For git commit messages, set spell checker
autocmd FileType gitcommit set spell

" Neovim only
" Incremental ("live") substitute
set inccommand=split

" Ale config
let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'

" Map space to fzf's file finder
map <Space> :Files<Enter>
