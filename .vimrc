"VIM RUN COMMANDS baudiber March 2019
"to reload without restart = :source $MYVIMRC  or  :so % 
"good plugin source: https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html
"font idea https://github.com/be5invis/Iosevka

"------------------------------------------------------------------------------
"==========================     VIM PLUG INSTALL    ===========================

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"------------------------------------------------------------------------------
"==========================     VIM PLUG PLUGINS    ===========================

call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'bluz71/vim-moonfly-colors'
Plug 'tpope/vim-fugitive'
Plug 'bfrg/vim-cpp-modern'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim' "enables additional text objects
Plug 'rhysd/clever-f.vim' "more informative f,F,t,T movements
Plug 'ajh17/VimCompletesMe'

call plug#end()

"to install plugins, resource vimrc and :PlugInstall


"------------------------------------------------------------------------------
"==========================     PLUGins Settings    ===========================
"clever-f
let g:clever_f_across_no_line    = 1
let g:clevef_f_fix_key_direction = 1
let g:clever_f_timeout_ms        = 3000
"vimcompletesme
autocmd FileType css,scss let b:vcm_tab_complete = "omni"


"------------------------------------------------------------------------------
"==========================     VIM MODS            ===========================

"execute pathogen#infect()
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"------------------------------------------------------------------------------
"==========================     KEY PLUGINS         ===========================

:let mapleader = " "  " Use space as <mapleader> key
nnoremap <leader>e :Ex<CR>
"nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
nnoremap <leader>t :term<cr>
nnoremap <leader>v :vsplit 
nnoremap <leader>S :set scrolloff=50<cr>
nnoremap <leader>D :set scrolloff=20<cr>
nnoremap <leader>s :set scrolloff=1<cr>
nnoremap <leader>N :set relativenumber!<cr>
nnoremap <leader>n :set number!<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader>w <C-w>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>c :vsp ~/.vimrc<cr>
nnoremap j gj
nnoremap k gk
"nmap <silent> <RIGHT>			:cnext<CR>
nmap <silent> <RIGHT>			:bnext<CR>
"nmap <silent> <RIGHT><RIGHT>	:cnfile<CR><C-G>
"nmap <silent> <LEFT>			:cprev<CR>
nmap <silent> <LEFT>			:bprev<CR>
"nmap <silent> <LEFT><LEFT>		:cpfile<CR><C-G>
nnoremap / /\v
nmap <silent> <BS> :nohlsearch<CR>

"------------------------------------------------------------------------------
"==========================     VIM SETTINGS        ===========================

syntax enable		" Active la coloration syntaxique
set backspace=indent,eol,start
"set mouse=a			" Permet d'utiliser la souris
set title			" Met a jour le titre du terminal
set number			" Affiche le numero de ligne
set ruler			" Affiche la position actuelle du curseur
set wrap			" Affiche les lignes trop longues sur plusieur lignes
set linebreak		" Ne coupe pas les mots
set scrolloff=50	" Affiche un minimum de 5 lignes autour du curseur
set shiftwidth=4	" Regle les tabulations automatiques sur 4 espaces
set tabstop=4		" Regle l'affichage des tabulations sur 4 espaces
set splitright		" Ouvre les verticalsplit sur la droite
set splitbelow		" open horizontal splits below
set laststatus=2	" Affiche la bar de status
set cc=80			" Change la couleur de fond a 80 colonnes
set showcmd			" Affiche les commandes incompletes
set wildmenu		" Show autocompletion possibles
set wildmode=longest:full,full
"set noshowmode		" Dont show -- INSERT --, -- VISUAL -- whene changing mode
set ignorecase		" Ignore la casse lors d'une recherche
set hidden
set smartcase		" Sauf si la recherche contient une majuscule
set incsearch		" Surligne le resultat pendant la saisie
set cindent			" smart indentation for C language
set noswapfile		" vim no longer creates .swp files
set listchars=tab:→\ ,trail:·,eol:¬,extends:…,precedes:…
set hlsearch		" hightlight search 
set cursorline		" highlight current line
"set cursorcolumn
set matchpairs+=<:>,=:;
syntax sync minlines=300 " syntax to be processed for only 300 lines at a time
"set synmaxcol=100        " syntax max X 
set regexpengine=1
set ttyfast
set ttimeout		"time waited for key press to complete
set ttimeoutlen=50
"set completeopt=longest,menuone,preview
set autoread
"let g:netrw_banner=0 "config Exporer
"let g:netrw_winsize=20
"let g:liststyle=3
set formatoptions-=cro	"disable autocomments on new line
au VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cul
au WinLeave,FocusLost,CmdwinLeave * set nocul

"------------------------------------------------------------------------------
"==========================     VIM HELLO LINE      ===========================

autocmd VimEnter * echo "OwO What's this?"

"------------------------------------------------------------------------------
"==========================     VIM THEME           ===========================

set termguicolors
"let ayucolor="light"
let ayucolor="mirage"
"let ayucolor="dark"
"colorscheme onedark
"colorscheme one
colorscheme moonfly
"set background=dark " for the dark version
let g:airline_theme='one'
"let g:airline_theme='onedark'
let g:one_allow_italics = 1 " I love italic for comments

"------------------------------------------------------------------------------
"==========================     HELP IN NEW TAB     ===========================

"Only apply to .txt files...
augroup HelpInTabs
	autocmd!
	autocmd BufEnter	*.txt	call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
	if &buftype == 'help'
		"Convert the help window to a tab...
		execute "normal \<C-W>T"
	endif
endfunction

"------------------------------------------------------------------------------
"==========================     PERSISTENT UNDO     ===========================

if has('persistent_undo')
	set undofile
	set undodir=$HOME/.VIM_UNDO_FILES
endif
