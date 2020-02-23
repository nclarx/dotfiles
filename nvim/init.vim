" Installs Plugin Manager Plugged 

function! InstallPlugged() 
	echo "downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd vimenter * PlugInstall
endfunction 

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  "InstallPlugged()
endif

" PLUGINS 
  call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion 
    Plug 'junegunn/goyo.vim' " Distraction free writing with <Leader>ff
    Plug 'francoiscabrol/ranger.vim' "https://github.com/francoiscabrol/ranger.vim
    Plug 'rbgrouleff/bclose.vim' "dependency of ranger.vim
    Plug 'scrooloose/nerdtree' " Filebrowser
    Plug 'vimwiki/vimwiki' " Wiki inside Vim
    Plug 'ryanoasis/vim-devicons'
    Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
    "plug 'prettier/vim-prettier', { 'do': 'yarn install' }
    Plug 'ajmwagar/vim-deus' " Current theme
    Plug 'herringtondarkholme/yats.vim' " TS Syntax
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'gregsexton/MatchTag'
  call plug#end()

" Base Settings

  colorscheme deus

	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

  if (has("termguicolors"))
   set termguicolors
  endif

  hi normal guibg=#070707
  hi Insert guibg=#070707
  hi Visual guibg=#070707
  hi Comment guifg=#EEEEEE
  hi Comment guibg=#373b41

	set relativenumber
	set smarttab
	set cindent
	set tabstop=2
	set shiftwidth=2
	" always uses spaces instead of tab characters
	set expandtab

" KEY BINDINGS ================================= 

  " Goyo
  map <leader>ff :Goyo<CR> 


	" j and k move up and down visually, not per line 
	noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
	noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

	inoremap jk <ESC>
	nmap <C-n> :NERDTreeToggle<CR>

" Status Line
	set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

" Coc Mappings

 nmap <leader>d <Plug>(coc-diagnostic-info)

" PLUGIN CONFIG

	" ctrlp - fuzzy search
		let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']



" COC Config

	" COC Bindings
		command! -nargs=0 Prettier :CocCommand prettier.formatFile
  

  " COC Config
	let g:coc_global_extensions = [
		\ 'coc-snippets',
		\ 'coc-pairs',
		\ 'coc-tsserver',
		\ 'coc-eslint',
		\ 'coc-prettier',
		\ 'coc-json',
		\ ]
	" from readme
	" if hidden is not set, TextEdit might fail.
	set hidden 
	set updatetime=3000

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
	"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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
	nmap <F2> <Plug>(coc-rename)

	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

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


" RANGER INTEGRATION

let g:ranger_map_keys = 0
map <leader>x :Ranger<CR>

" GOYO

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  hi normal guibg=#070707
  hi Insert guibg=#070707
  hi Visual guibg=#070707
  hi Comment guifg=#EEEEEE
  hi Comment guibg=#373b41
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  hi normal guibg=#070707
  hi Insert guibg=#070707
  hi Visual guibg=#070707
  hi Comment guifg=#EEEEEE
  hi Comment guibg=#373b41
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" VIMWIKI

let wiki_1 = {}
let wiki_1.path = '~/vimwiki/dev/'
let wiki_1.path_html = '~/vimwiki/dev/dev_html/dev/'
let wiki_1.automatic_nested_syntaxes=1

let wiki_2 = {}
let wiki_2.path = '~/vimwiki/private/'
let wiki_2.path_html = '~/vimwiki/private/private_html/'
let wiki_2.automatic_nested_syntaxes=1

let g:vimwiki_list = [wiki_1, wiki_2]

autocmd VimEnter * if argv() ==# ['vpw'] | execute "normal '2\<Leader>ww'" | endif
autocmd VimEnter * if argv() ==# ['vxx'] | execute "normal '1\<Leader>ww'" | endif
