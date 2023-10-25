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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'https://github.com/altercation/vim-colors-solarized'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
call plug#end()

" https://www.reddit.com/r/neovim/comments/r9acxp/neovim_is_slow_because_of_python_provider/
" https://neovim.io/doc/user/provider.html#provider-python
" Neovim tries to loads a python provider 'pythonx'. This allows users to
" write plugins using python.
" I don't think any of my plugins use python, but because I open a python
" file, it tries to load the python provider.
" What I've done here is I've created a virtualenv containing the `pynvim`
" package, which is what nvim uses. We'll point to this virtualenv so when
" loading python files it won't be slow.
let g:python3_host_prog = '/Users/ang/pynvim'

" UI settings
syntax on                       " Enable syntax highlighting
set number                      " Show line numbers
colorscheme catppuccin-frappe

set textwidth=0                " Autowrap text that goes beyond indicated limit
set colorcolumn=+1              " Show textwidth limit bar
highlight ColorColumn ctermbg=8 " Set the textwidth limit bar to be dark gray

set cursorline                  " Highlight currently focused line

set expandtab                   " Use spaces instead of tabs
set tabstop=2                   " Indicates how many spaces in a tab
set shiftwidth=2                " Indicates number of spaces for autoindent

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" Netrw (file browser) configs
" https://shapeshed.com/vim-netrw/ Also when in netrw, can use F1 to see help options
let g:netrw_liststyle=3 " Set view to tree style
let g:netrw_banner=0    " Remove the banner

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

""""""""""""""" Extension Configurations """""""""""""""
" fzf
" Map space to fzf's file finder
map <Space> :Files<Enter>
" When you type leader + rg, open up Rg and search for the word under the cursor
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

"""""""" CoC """"""""
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-pyright',
  \ 'coc-prettier',
  \ ]

" Add Prettier command
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Settings mostly copied from example config: https://github.com/neoclide/coc.nvim#example-vim-configuration
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
"""""""" CoC """"""""

" let g:gutentags_cache_dir="~/.cache/tags"
" Ale config
" let g:ale_ruby_rubocop_executable = 'bundle exec rubocop'
" End Extension Configurations
""""""""""""""" Extension Configurations """""""""""""""
