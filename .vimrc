set nocompatible

" Use Pathogen to manage plugins
filetype off
" call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Set backup directory for ~ files
set backup
set backupdir=~/tmp/.vim/backup,/tmp
set directory=~/tmp/.vim/tmp

" General settings
syntax on
set expandtab
set autoindent
set sts=2
set shiftwidth=2
set scrolljump=5
set scrolloff=3
set backspace=2
set ruler
set number

" Better searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Easy to clear searches
nnoremap <leader><space> :noh<cr>

" Turn on mouse support in xterm
set mouse=a

" Turn on relative number support
" set relativenumber

" Turn on undo file
" set undofile

" Colors
set t_Co=256
colors wombat256

" Commenting with EnhancedCommentify
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'
let g:EngCommentifyMultiPartBlocks = 'Yes'
let g:EnhCommentifyUseBlockIndex = 'Yes'


" Obvious Mode
set laststatus=2
" let g:obviousModeInsertHi = 'term=reverse ctermbg=1'

" VSA dictionary for autocomplete
set dictionary+=/home/hparmar/.vim/vsa_dict.txt

" Omnifunc / Omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Make text highlighting nicer
set hl=l:Visual

" Open and close all the three plugins on the same time 
" nmap <F8>   :TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
" nmap <F9>   :TrinityToggleSourceExplorer<CR> 
" Open and close the taglist.vim separately 
" nmap <F10>  :TrinityToggleTagList<CR> 
" Open and close the NERD_tree.vim separately 
" nmap <F11>  :TrinityToggleNERDTree<CR>

" Set up toggles for Taglist and NERDTree
nmap <F10>  :TlistToggle<CR> 
nmap <F11>  :NERDTreeToggle<CR>

let g:NERDSpaceDelims=1
let g:NERDRemoveExtraSpaces=1
let g:NERDDefaultNesting=0
let g:NERDTreeWinPos = 'right'

" Set paste mode
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>
set showmode

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Attach 'run this file' with the shebang to F5
au BufEnter *
\if match( getline(1) , '^\#!') == 0 |
\ execute("let b:interpreter = getline(1)[2:]") |
\endif

fun! CallInterpreter()
    if exists("b:interpreter")
         exec ("!".b:interpreter." %")
    endif
endfun

" map <F5> :call CallInterpreter()<CR>

" Add SVN Commit to F6 and SVN Info to F7
map <F6> :VCSCommit<CR>
map <F7> :VCSInfo<CR>

" Get the hell out of insert mode
"   with 'kj'
" Turn off arrow keys 
inoremap kj <Esc>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

" Let scripts autoinstall
let g:GetLatestVimScripts_allowautoinstall=1
