"VIM RUN COMMANDS baudiber March 2019
"to reload without restart = :source $MYVIMRC  or  :so % 
"good plugin source: https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html
"font idea https://github.com/be5invis/Iosevka

"------------------------------------------------------------------------------
"==========================           42            ===========================

"if filereadable(expand("/usr/share/vim/vim80/plugin/stdheader.vim"))
"    source /usr/share/vim/vim80/plugin/stdheader.vim
"endif

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

" leader G to focus on one file
Plug 'junegunn/goyo.vim'
" themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'tpope/vim-fugitive'
Plug 'bfrg/vim-cpp-modern'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --no-bash' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim' "enables additional text objects
Plug 'rhysd/clever-f.vim' "more informative f,F,t,T movements
Plug 'bfrg/vim-cpp-modern'
Plug 'noahfrederick/vim-skeleton'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lsp'
Plug 'pbondoer/vim-42header'

call plug#end()

"to install plugins, resource vimrc and :PlugInstall

"------------------------------------------------------------------------------
"==========================     PLUGins Settings    ===========================
"clever-f
let g:clever_f_across_no_line    = 1
let g:clevef_f_fix_key_direction = 1
let g:clever_f_timeout_ms        = 3000
"vimcompletesme
"autocmd FileType css,scss let b:vcm_tab_complete = "omni"


"------------------------------------------------------------------------------
"==========================        COC              ===========================

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nn <silent> K :call CocActionAsync('doHover')<cr>
nnoremap <C-p> :GFiles<CR>
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
colorscheme gruvbox
"colorscheme moonfly
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
