let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'chrisbra/csv.vim'                                                   " CSV editing
Plug 'easymotion/vim-easymotion'                                          " Text navigation
Plug 'haya14busa/incsearch.vim'                                           " Incremental search
Plug 'haya14busa/incsearch-easymotion.vim'                                " Incremental search with easymotion
Plug 'junegunn/vim-easy-align'                                            " Align text
Plug 'junegunn/vim-emoji'                                                 " Emoji support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                       " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                                   " Fuzzy file finder
if !has('nvim') && v:version >= 900
  Plug 'vim-fuzzbox/fuzzbox.vim'                                          " Fuzzy finder nativo (Vim 9+)
endif
Plug 'junegunn/limelight.vim'                                             " Highlight matching parenthesis
Plug 'junegunn/vim-slash'                                                 " Slash commands
Plug 'voldikss/vim-floaterm'                                              " Floating terminal
Plug 'airblade/vim-gitgutter'                                             " Git integration
Plug 'camspiers/lens.vim'                                                 " Lens
Plug 'vim-airline/vim-airline'                                            " Airline
Plug 'godlygeek/tabular'                                                  " Text filtering and alignment
if executable('node')
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " Markdown preview (precisa de node)
endif
Plug 'plasticboy/vim-markdown'                                            " Markdown editing
Plug 'terryma/vim-multiple-cursors'                                       " Multiple cursors
Plug 'preservim/nerdtree'                                                 " File tree
Plug 'preservim/nerdcommenter'                                            " Commenting out code
Plug 'frazrepo/vim-rainbow'                                               " Rainbow brackets
Plug 'tpope/vim-commentary'                                               " Commenting out code
Plug 'tpope/vim-fugitive'                                                 " Git integration
Plug 'tpope/vim-repeat'                                                   " Repeat last change
Plug 'tpope/vim-sensible'                                                 " Sensible defaults
Plug 'tpope/vim-surround'                                                 " Surround text
Plug 'kshenoy/vim-signature'                                              " Place, toggle and display marks
Plug 'honza/vim-snippets'                                                 " Snippets
Plug 'mhinz/vim-startify'                                                 " Start screen
Plug 'wellle/targets.vim'                                                 " Add text objects to help navigation
Plug 'ryanoasis/vim-devicons'                                             " Show icons for files
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'                                            " Plenary (so no neovim)
  Plug '3rd/image.nvim'                                                   " Image viewer (so no neovim)
endif
Plug 'sheerun/vim-polyglot'                                               " Syntax highlighting
Plug 'dense-analysis/ale'                                                 " Linting
Plug 'kcsongor/vim-tabbar'                                                " Tabbar
Plug 'morhetz/gruvbox'
if executable('go')
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                      " Go (precisa do go)
endif

" LSP e Autocompletion (precisam de node, pulados em server sem node)
if executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}                         " LSP client + autocompletion
  Plug 'github/copilot.vim'                                               " GitHub Copilot (gratuito para uso pessoal)
endif

" All of your Plugins must be added before the following line
call plug#end()

" Settings
set autochdir                              " Set working directory to current folder
set autoread                               " Reload files
set backspace=indent,eol,start             " Backspacing over everything in insert mode
set belloff+=ctrlg                         " If Vim beeps during completion
set clipboard=unnamed                      " Use y to copy text to clipboard
set completeopt+=menuone,noselect,noinsert " Autocomplete options
set completeopt-=preview                   " Remove preview
set confirm                                " Y-N-C prompt if closing with unsaved changes
set expandtab                              " Expand tabs into spaces
set encoding=utf8                          " Enconding for vim-devicons
set fo-=t                                  " Formatting
set guicursor=i:ver25-iCursor              " Cursor size
set guifont=MesloLGL\ Nerd\ Font\ Mono:h14  
set hidden                                 " No unsaved buffer warnings
set hlsearch                               " Highlight all search results
set ignorecase                             " Always case-insensitive
set incsearch                              " Searches for strings incrementally
set laststatus=2                           " Show status bar
set linebreak                              " Break lines
set nolist                                   " List
set modeline                               " Set variables specific to files
set mouse=a                                " Mouse support
set mousehide                              " Hide mouse when typing
set nobackup                               " No backup~ files
set nospell                                " Turn off spell check (see below)
set number relativenumber                  " Show line numbers
set path+=**                               " Fuzzy find files
set shiftwidth=2                           " Indent
set shortmess+=c                           " Shut off completion messages
set showmatch                              " Show matching pair for [] {} and ()
set showtabline=2                          " Show tablines
set smartcase                              " Enable smart-case search
set smartindent                            " Smart indentation
set smarttab                               " Enable smart-tabs
set softtabstop=2                          " Tab
set spelllang=en_US,pt_BR                  " US English and Brazilian Portuguese
set splitright                             " Always split right
set tabstop=2                              " Number of spaces per Tab
set tw=0                                   " Textwidth
set undolevels=1000                        " Number of undo levels
set belloff=all                            " No bells
set noerrorbells                           " No error bells
set novisualbell                           " No visual bells
set wildmenu                               " Show menu autocomplete options
set wildmode=longest,list,full             " Options for wildmenu
set noswapfile                             " No swapfile
set nowritebackup                          " No backup files
set undodir=/tmp                           " Undo directory
set undofile                               " Undo files

" Move linha ou bloco selecionado pra cima/baixo
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Mostrar doc em popup (requer Vim 8.2+)
let g:go_doc_popup_window = 1

" ========== Gruvbox Theme ==========
set background=dark    " ou 'light' se preferir o tema claro
silent! colorscheme gruvbox

" Opcionais para melhorar o visual
let g:gruvbox_contrast_dark = 'medium'  " 'soft', 'medium', 'hard'
let g:gruvbox_italic = 1

let g:airline_powerline_fonts = 1

" Reduz o tempo de espera após pressionar o leader
set timeoutlen=600  " ou até 300 se preferir mais rápido
set ttimeoutlen=20  " Delay para códigos de teclas (escape, etc)

syntax enable

let g:tabbar_show_buffers = 1
let g:tabbar_show_unlisted = 0
let g:tabbar_show_tab_indicators = 1

" Set specific formatters for different languages
let g:ale_fixers = {
\ '*': ['clang-format'],
\ 'python': ['black', 'isort'],
\ 'javascript': ['prettier', 'eslint'],
\ 'json': ['jq'],
\ 'go': ['gofmt'],
\ 'rust': ['rustfmt'],
\ 'html': ['prettier']
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'json': ['clang-format'],
\   'go': ['gopls'],
\}

let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1

" Lens config
" let g:lens#disabled = 1
let g:lens#animate = 0
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

" Remap leader to space
" nnoremap <SPACE> <Nop>
let mapleader=" "

" Fix code with ALE
nnoremap <Leader>ff :ALEFix<CR>

" Save with Ctrl+S
nmap <C-s> :w <CR>
imap <C-s> <ESC>:w<CR>a
vmap <C-s> <ESC>:w<CR>gv

" Open a terminal in a vertical split
nnoremap <Leader>vt <cmd>:vert term<cr>

" Spelling
au FileType rmd,md,markdown,pandoc,tex,latex syntax spell toplevel
au FileType rmd,md,markdown,pandoc,tex,latex,bib,bibtex setl spl=en_gb,pt_br spell
map <Leader>ns :set nospell<CR>

" Turn off search highlighting
map <Leader>n :noh <CR>

" GitGutter
let g:gitgutter_max_signs = 500

" fzf
" nmap <Leader><S-F> :execute 'FZF' fnameescape(expand('%:p:h'))<CR>
" let g:vim_start_dir = fnameescape(expand('%:p:h'))
" nnoremap <leader><S-F> :execute 'Files' fnameescape(g:vim_start_dir)<CR>

if empty(expand('%:p'))
  let g:vim_start_dir = getcwd()
else
  let g:vim_start_dir = fnameescape(expand('%:p:h'))
endif

" Configurações de performance do FZF
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.7 } }  " Mais rápido que popup window

" Ou se quiser preview, limite o tamanho
" let g:fzf_preview_window = []  " Desabilita preview se não usar

nnoremap <leader>f :execute 'Files' g:vim_start_dir<CR>
" nnoremap <leader>f :Files<CR>

" Custom actions (similar ao NERDTree)
let g:fzf_action = {
  \ 'enter':  'edit',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-i': 'split',
  \ 'ctrl-t': 'tab split',
  \ }

" ========== Fuzzbox ==========
" Prompt no topo, igual ao Cmd+P do VSCode
let g:fuzzbox_dropdown = 1

" Buscador de arquivos: Fuzzbox no Vim 9+, fzf nas versoes antigas
function! ClowkFuzzyFiles() abort
  if exists(':FuzzyFilesRoot') == 2
    FuzzyFilesRoot
  elseif exists(':Files') == 2
    execute 'Files' g:vim_start_dir
  else
    echohl WarningMsg | echo 'Nenhum fuzzy finder instalado' | echohl None
  endif
endfunction

" Barra de espaco 2x (<Leader><Space>) abre a busca de arquivos
nnoremap <silent> <Leader><Space> :call ClowkFuzzyFiles()<CR>


" Highlight yanks
let g:highlightedyank_highlight_duration = -1

" Delete all marks
nmap <Leader>dm :delm! <bar> delm A-Z0-9<CR>

" Rainbow parentheses
let g:rainbow_active = 1

" Floaterm
let g:floaterm_position     = 'center'
nmap <Leader>t :FloatermToggle<CR>
nmap <F7> :FloatermNew --wintype=normal --position=right<CR>
nmap <F8> :FloatermNew --wintype=normal --position=right radian<CR>
nmap <F9> :FloatermNew --wintype=normal --position=right python3<CR>
let g:floaterm_keymap_next   = '<F10>'
let g:floaterm_keymap_toggle = '<F11>'
let g:floaterm_keymap_kill   = '<F12>'
let g:floaterm_opener        = 'vsplit'
nmap <Leader>zf :FloatermNew fzf<CR>
nmap <Leader>l :FloatermSend <CR>
nmap <S-CR> :FloatermSend <CR>
vmap <Leader>l :'<,'>FloatermSend <CR>
vmap <S-CR> :'<,'>FloatermSend <CR>

" Vim Easy Align (ga: <Leader>ea atrasaria o <Leader>e do NERDTree)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Moving text
vmap J :m '>+1<CR>gv=gv
vmap K :m '<-2<CR>gv=gv

" Yank/paste to the OS clipboard with <Leader>y and <Leader>p
nmap <Leader>y "+y
nmap <Leader>Y "+y$
nmap <Leader>p "+p
nmap <Leader>P "+P
nmap <C-a> :%y+ <CR>

" Select all
nmap <C>a ggXG<CR>

" Deactivate arrows
" nmap <Up> <Nop>
" nmap <Down> <Nop>
" nmap <Left> <Nop>
" nmap <Right> <Nop>

" In insert or command mode, move normally by using Ctrl
cnoremap <C-S-b> <C-O><S-b>
cnoremap <C-S-w> <C-O><S-w>
cnoremap <C-b> <C-O>b
cnoremap <C-e> <C-O>e<C-O>l
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-w> <C-O>w
inoremap <C-S-b> <C-O><S-b>
inoremap <C-S-w> <C-O><S-w>
inoremap <C-b> <C-O>b
inoremap <C-e> <C-O>e<C-O>l
" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>
inoremap <C-w> <C-O>w

" Auto-save
let g:auto_save        = 1
let g:auto_save_events = ["InsertLeave"]
nmap <Leader>as :AutoSaveToggle<CR>

" Write good
nmap <Leader>wg :WritegoodToggle<CR>

" Git
nmap <leader>ga :Gwrite<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gbr :Git branch<Space>
nmap <leader>gca :Git commit --amend<CR>
nmap <leader>gcam :Git commit --amend --no-edit<CR>
nmap <leader>gco :Gcheckout<Space>
nmap <leader>gd :GDelete<CR>
nmap <leader>gf :Gfetch<CR>
nmap <leader>gl :silent! Glog<CR>
nmap <leader>gm :Git merge<CR>
nmap <leader>gpb :Git pull --rebase<CR>
nmap <leader>gpl :Git pull<CR>
nmap <leader>gps :Git push<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gv :Gvdiffsplit<CR>

" Gist.vim
let g:gist_clip_command     = 'pbcopy'
let g:gist_detect_filetype  = 1
let g:gist_get_multiplefile = 1
let g:gist_post_private     = 1
let g:gist_show_privates    = 1
let g:github_token          = ''
let g:github_user           = 'danilofreire'
nmap <Leader>ge :Gist -e -s
nmap <Leader>gi :Gist -b -s
nmap <Leader>gpri :Gist -p -s
nmap <Leader>gx :Gist -d<CR>

" Sort - alphabetically, numbers, reverse
vmap <Leader>sa :'<,'>sort u<CR>
vmap <Leader>sn :'<,'>sort n<CR>
vmap <Leader>sr :'<,'>sort!<CR>

" Vim-Polyglot
" let g:polyglot_disabled = ['latex']

" Markdown
let g:vim_markdown_auto_insert_bullets  = 0
let g:vim_markdown_conceal              = 0
let g:vim_markdown_conceal_code_blocks  = 0
let g:vim_markdown_frontmatter          = 1
let g:vim_markdown_math                 = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_strikethrough        = 1
let g:vim_markdown_toc_autofit          = 1

" Table mode
nmap <Leader>mm :TableModeToggle<CR>

" MarkdownPreview
let g:mkdp_refresh_slow                 = 1
nmap <Leader>mp :MarkdownPreview<CR>
nmap <Leader>ms :MarkdownPreviewStop<CR>

" Format
nmap Q {gq}
nmap QQ gggqG

" Vimtex Config
let g:tex_conceal                      = ''
let g:vimtex_fold_enabled              = 1
let g:vimtex_quickfix_open_on_warning  = 0
set conceallevel=0

" Limelight config
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg        = 'gray'
let g:limelight_conceal_ctermfg        = 240
let g:limelight_default_coefficient    = 0.7
nmap <Leader>L :Limelight!! <CR>i<Esc>`^

" Close tab
nmap <Leader>x :bd <CR>

" Map ESC to leave terminal
" :tnoremap <Esc> <C-\><C-n>

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Indentation
filetype indent on

" Enable file type detection, necessary for language-specific settings
filetype plugin indent on

au FileType r,html,css,javascript,json,yaml,yml,conf setl ts=2 sw=2 sts=2 et

" Wrap/unwrap text
function! WrapText()
  let tw = &textwidth
  if tw==80
    set tw=0
  else
    set tw=80
  endif
endfunc
nmap <Leader>tw :call WrapText()<CR>

" Toggle relativenumber
function! NumberToggle()
  if(&rnu == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nmap <Leader>rn :call NumberToggle()<CR>

" Remove all trailing whitespace by pressing F6
nmap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Clear highlighting by pressing Enter in normal modemap
imap <C-v> <ESC>"+pa

" Move buffers
nmap <Leader>1 :bfirst <CR>
nmap <Leader>2 :bfirst <bar> :bn<CR>
nmap <Leader>3 :bfirst <bar> :2bn<CR>
nmap <Leader>4 :bfirst <bar> :3bn<CR>
nmap <Leader>5 :bfirst <bar> :4bn<CR>
nmap <Leader>6 :bfirst <bar> :5bn<CR>
nmap <Leader>7 :bfirst <bar> :6bn<CR>
nmap <Leader>8 :bfirst <bar> :7bn<CR>
nmap <Leader>9 :bfirst <bar> :8bn<CR>

" Navigate around splits with a single key combo
nmap <C-l> <C-w><C-l>
nmap <C-h> <C-w><C-h>
nmap <C-k> <C-w><C-k>
nmap <C-j> <C-w><C-j>

" Format the entire buffer as pretty JSON
nnoremap <silent> <Leader>fj :%! jq .<CR>

" Format a visual selection as pretty JSON
vnoremap <silent> <Leader>fj :'<,'>! jq .<CR>

" Format the entire buffer as compact JSON
nnoremap <silent> <Leader>fcj :%! jq --compact-output .<CR>

" Format a visual selection as compact JSON
vnoremap <silent> <Leader>fcj :'<,'>! jq --compact-output .<CR>

" ========== NERDTree Config ==========
" nnoremap <leader>e :NERDTreeToggle<CR>
" nnoremap <leader>n :NERDTreeFocus<CR>

" Desabilita netrw (navegador padrão do Vim) para usar apenas NERDTree
let g:NERDTreeHijackNetrw = 1
let loaded_netrwPlugin = 1

nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nf :NERDTreeFind<CR>

let g:NERDTreeChDirMode = 1
let g:NERDTreeFileLines = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let NERDTreeIgnore=[".swp"]

autocmd FileType nerdtree setlocal winfixwidth

" Fecha o Vim automaticamente se o NERDTree for o único buffer aberto
augroup NerdTreeAutoQuit
  autocmd!
  autocmd BufEnter * if tabpagenr('$') == 1 
        \ && winnr('$') == 1 
        \ && exists('b:NERDTree') 
        \ && b:NERDTree.isTabTree() 
        \ | quit | endif
augroup END

" Abre o NERDTree dependendo do contexto
augroup NerdTreeAutoOpen
  autocmd!
  autocmd StdinReadPre * let s:std_in=1

  " 1. Sem argumentos → abre NERDTree no diretório atual
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') |
      \ NERDTree |
      \ wincmd h | " garante que o foco começa no NERDTree
      \ endif

  " 2. Abrindo um diretório → entra nele, abre NERDTree, mantém foco
  autocmd VimEnter * if argc() == 1 && isdirectory(argv(0)) && !exists('s:std_in') |
        \ execute 'cd' fnameescape(argv(0)) |
        \ enew | " cria um buffer vazio, editável
        \ execute 'NERDTree' fnameescape(argv(0)) |
        \ wincmd h | " foca o NERDTree
        \ endif

  " 3. Abrindo um arquivo → abre o arquivo e o NERDTree na mesma pasta
  autocmd VimEnter * if argc() == 1 && filereadable(argv(0)) && !exists('s:std_in') |
        \ execute 'NERDTree' fnameescape(fnamemodify(argv(0), ':p:h')) |
        \ execute 'NERDTreeFind' |
        \ wincmd l | " foca o arquivo, não o NERDTree
        \ endif
augroup END

" Sincroniza o NERDTree com o buffer atual (sem roubar foco)
augroup NerdTreeSync
  autocmd!
  autocmd BufEnter * if exists('t:NERDTreeBufName')
        \ && bufwinnr(t:NERDTreeBufName) != -1
        \ && expand('%') !~ 'NERD_tree_' |
        \ let curwin=winnr() |
        \ silent! NERDTreeFind |
        \ execute curwin . 'wincmd w' |
        \ endif
augroup END

" ========== GitHub Copilot ==========
" Aceitar sugestão com Tab (se não estiver em menu de completion)
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Navegação entre sugestões
imap <C-]> <Plug>(copilot-next)
imap <C-[> <Plug>(copilot-previous)

" Desabilitar para tipos específicos de arquivo
let g:copilot_filetypes = {
    \ 'gitcommit': v:false
    \ }


" ESC para fechar o popup E sair do insert mode
inoremap <Esc> <Esc>