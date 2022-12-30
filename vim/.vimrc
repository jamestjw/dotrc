
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

if v:progname =~? "evim"
  finish
endif

if !has('nvim')
	" Get the defaults that most users want.
	source $VIMRUNTIME/defaults.vim
endif
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
set tags=tags


" Opt out of persistent undo
set noundofile
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files

"  Rails 
set number
syntax on
filetype plugin indent on
filetype on
filetype indent on

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" remap envoke key
nnoremap <silent> <C-z> :FZF<CR>

" RG search shortcut f + w (find word)
nnoremap fw :Rg<CR>

Plug 'Keithbsmiley/swift.vim'

" Perl
Plug 'wolfgangmehner/perl-support'

" Background
Plug 'joshdick/onedark.vim'
syntax on
colorscheme onedark

" Nerdtree file explorer
Plug 'preservim/nerdtree'
nnoremap tr :NERDTreeToggle<CR>

" Golang
Plug 'fatih/vim-go'
" Jump to test file
nnoremap ga :GoAlternate<CR>
" Shortcut for searching for function name
nnoremap ff :GoDeclsDir<CR> 

Plug 'ctrlpvim/ctrlp.vim'

" Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Run goimports along gofmt on each save
let g:go_fmt_command = "goimports"
" Automatically get signature/type info for object under cursor
let g:go_auto_type_info = 1

" Coc config start
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" <CR> to accept autocomplete
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
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
 else
 call CocAction('doHover')
 endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
augroup mygroup
 autocmd!
 " Setup formatexpr specified filetype(s).
 autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
 " Update signature help on jump placeholder.
 autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p :<C-u>CocListResume<CR>

" Coc config end

Plug 'vim-airline/vim-airline'

" Rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" For assembly syntax
Plug 'shirk/vim-gas'
" For TOML syntax
Plug 'cespare/vim-toml' 

Plug 'will133/vim-dirdiff'

Plug 'vim-scripts/indentpython.vim'

" plenary.nvim https://github.com/nvim-lua/plenary.nvim
Plug 'nvim-lua/plenary.nvim'

Plug 'scalameta/nvim-metals'

call plug#end()

" Remove highlighting from search on return
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Commenting out code
" Commenting blocks of code.
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala,rs let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType mail             let b:comment_leader = '> '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" Detect .h files as c type
autocmd BufRead,BufNewFile *.h,*.c set filetype=c
" C indentation
autocmd FileType c,h setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType asm setlocal expandtab shiftwidth=2 tabstop=2

" Toggle between c and h files
function! HeaderToggle() " bang for overwrite when saving vimrc
let file_path = expand("%")
let file_name = expand("%<")
let extension = split(file_path, '\.')[-1] " '\.' is how you really split on dot
let err_msg = "There is no file "

if extension == "c" || extension == "cpp"
    let next_file = join([file_name, ".h"], "")

    if filereadable(next_file)
    :e %<.h
    else
        echo join([err_msg, next_file], "")
    endif
elseif extension == "h"
    let next_file = join([file_name, ".c"], "")

    if filereadable(next_file)
        :e %<.c
    else
	let next_file = join([file_name, ".cpp"], "")
	if filereadable(next_file)
		:e %<.cpp
	else
		echo join([err_msg, next_file], "")
	endif
    endif
endif
endfunction

nnoremap <Leader>h :call HeaderToggle()<CR>

set mouse=a
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
" let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))

" Replace opam_available_tools with the below for better performance
let s:opam_available_tools = []
for tool in s:opam_packages
  let cmd_opam = "grep " . tool . " " . $OPAM_SWITCH_PREFIX . "/.opam-switch/switch-state | wc -l"
  let exists = system(cmd_opam)
  if exists > 0
    let s:opam_available_tools = s:opam_available_tools + [tool]
  endif
endfor

for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

" Haskell
autocmd FileType haskell setlocal expandtab shiftwidth=2 tabstop=2

"OCaml
"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"
set omnifunc=syntaxcomplete#Complete

" ## added by OPAM user-setup for vim / ocp-indent ## 3ef4be19aef6c4105fa35cb691754d48 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/Users/jamestjw/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line

" Markdown and text
autocmd FileType markdown,text setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
