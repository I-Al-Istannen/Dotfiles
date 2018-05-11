" vim: set foldmethod=marker :
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" I was tired of this plugin not loading correctly
set runtimepath+=~/.vim/dein/repos/github.com/lervag/vimtex/

filetype plugin indent on
syntax enable

" Dein {{{
" Required:
if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add Plugins {{{
  " Add or remove your plugins here:
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')


  " Completion for Python
  call dein#add('zchee/deoplete-jedi', {'on_ft': ['python']})
  " KOTLIN!
  call dein#add('udalov/kotlin-vim', {'on_ft': ['kotlin']})
  " File browser? This nice little bar replaces that.
  call dein#add('scrooloose/nerdtree')
  " The undotree can be fascinating, just hard to navigate
  call dein#add('mbbill/undotree')
  " Delimeters should be closed, shouldb't they?
  call dein#add('Raimondi/delimitMate')
  " A small status line
"  call dein#add('vim-airline/vim-airline')
  " A git integration
  call dein#add('tpope/vim-fugitive')
  " A linter engine
  call dein#add('w0rp/ale')
  " Sets the indentation depth to a heuristically determined value
  call dein#add('tpope/vim-sleuth')
  " Online thesaurus!
  call dein#add('Ron89/thesaurus_query.vim')
  " Tex!
  " call dein#add('lervag/vimtex', {'on_ft': ['tex']})
  call dein#add('lervag/vimtex', {'on_ft': ['tex']})
  " Generate tex tags
  call dein#add('ludovicchabant/vim-gutentags', {'on_ft': ['tex']})
  " Surround text with brackets or whatever you choose.
  call dein#add('tpope/vim-surround')
  " Align data and create tables the easy way.
  call dein#add('godlygeek/tabular')
  " This allows you to dot-repeat plugin commands!
  call dein#add('tpope/vim-repeat')
  " Visual indentation cues
  call dein#add('Yggdroot/indentLine')

  "  call dein#add('donRaphaco/neotex')

  " Markdown preview
  call dein#add('suan/vim-instant-markdown', {'on_ft': ['md']})

  call dein#add('PotatoesMaster/i3-vim-syntax', {'on_ft': ['i3']})

  " Color Schemes
  call dein#add('mhartington/oceanic-next')

  " }}}

  " Required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
" }}}

" Plugin settings {{{
" Airline {{{
"let g:airline#extensions#ale#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers=2
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_symbols = {}
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers=2
 " }}}

" VimTeX + Deoplete
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" vimtex luatex
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-interaction=nonstopmode',
      \ ],
      \}

" Indent lines
let g:indentLine_char = '▏'

" Thesaurus
let g:tq_enabled_backends=["woxikon_de", "thesaurus_com","openoffice_en"]
let g:tq_language=["de", "en"]

" Neosnippets
let g:neosnippet#snippets_directory="~/.vim/snippets"
" }}}

" Leader Setup {{{
" Set the leader char
let mapleader = ","
let maplocalleader = ","
" }}}

" Plugin commands and mappings {{{
" deoplete {{{
function! s:deoplete_lazy_enable()
 autocmd! deoplete_lazy_enable
 augroup! deoplete_lazy_enable
 call deoplete#enable()
endfunction
augroup deoplete_lazy_enable
 autocmd!
 autocmd CursorHold * call s:deoplete_lazy_enable()
 autocmd InsertEnter * call s:deoplete_lazy_enable()
        \ | silent! doautocmd <nomodeline> deoplete InsertEnter
augroup END

let g:deoplete#enable_smart_case = 1
autocmd CompleteDone * pclose
" }}}

" Neosnippet {{{2
" Use tab to expand
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB>
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" :
      \       pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" }}}2

" Delimit mate fix indentation {{{
" ripped out of delimitMate
function! s:TriggerAbb() "{{{
  if v:version < 703
        \ || ( v:version == 703 && !has('patch489') )
        \ || pumvisible()
    return ''
  endif
  return "\<C-]>"
endfunction "}}}
map <expr> <Plug>(delimitMateCR) <SID>TriggerAbb()."\<C-R>=delimitMate#ExpandReturn()\<CR>"
" }}}

" Thesaurus {{{
nmap <Leader>T :ThesaurusQueryLookupCurrentWord<CR>
" }}}
" }}}

" Commands and mappings {{{
map  <F5>	<ESC>:UndotreeToggle<cr>
imap <F5>	<ESC>:UndotreeToggle<CR>
nmap <C-o>      <ESC>:NERDTreeFind<CR>

" Make space toggle foldings
nmap <Space>    za

" Clear the search highlights according to
" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#comment5906101_657484
command C let @/=""

" Format Json using python
com! FormatJSON %!python -m json.tool
" }}}

" Themes {{{
if (has("termguicolors"))
 set termguicolors
endif

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let g:airline_theme='oceanicnext'
colorscheme OceanicNext
" }}}

" Syntax additions {{{

" Java: 'new', 'instanceof'
highlight Operator ctermfg=5  guifg=#d175bc

" }}}

" Filetype mappings {{{1
autocmd FileType tex setlocal spell
autocmd FileType tex setlocal spelllang=de,en
autocmd FileType tex setlocal conceallevel=0
" I have no freaking clue why vim is slow with them
autocmd FileType tex setlocal norelativenumber
"}}}1


" General SET commands {{{

" Show line numbers
set number
" And make them relative to the current line
set relativenumber

" Use the system clipboard, instead of an unnamed register
set clipboard+=unnamedplus

" Expand tabs to spaces
set expandtab
set shiftwidth=4
set softtabstop=4
" The character at the beginning of a wrapped line.
set showbreak=↪\ 
" The list chars. Possible value for "eol:↲" 
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" Activate the display of list chars.
set list

" Enable case insensitive search
set ignorecase
" Enable case sensitiue search when your pattern contains an uppercase letter otherwise it will be insensitive
set smartcase

" Tex flavour
let g:tex_flavor = 'latex'
" }}}
