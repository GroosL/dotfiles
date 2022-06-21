source $HOME/.config/nvim/vim-plug/plugins.vim
filetype plugin on

let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'

" Custom Keybindings

nnoremap zz :w!<cr>
nnoremap zx :wq<cr>
nnoremap zc :q!<cr>
nnoremap cc :!gcc % ; ./a.out<cr>
nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-n> :set relativenumber!<CR>
nnoremap <C-space> i
imap <C-space> <Esc>

" Auto Completion

filetype plugin on
set omnifunc=syntaxcomplete#Complete
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/autoload/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

" Customization
set encoding=utf8
set number
set relativenumber
set tabstop=4
syntax enable
set noshowmode
"let g:tokyonight_transparent = "true"
let g:webdevicons_enable_nerdtree = 1
let g:nord_disable_background = "false"
let g:dracula_colorterm = 0
let g:gruvbox_transparent_bg = 1
autocmd VimEnter * hi Normal ctermbg=none
colorscheme gruvbox 

" C Auto completion
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

" HTML close tags
function s:CompleteTags()
  inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
  inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()

" Minimalist-TabComplete-Plugin
inoremap <expr> <Tab> TabComplete()
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

"" Minimalist-AutoCompletePop-Plugin
"set completeopt=menu,menuone,noinsert
"inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
"autocmd InsertCharPre * call AutoComplete()
"fun! AutoComplete()
"    if v:char =~ '\K'
"        \ && getline('.')[col('.') - 4] !~ '\K'
"        \ && getline('.')[col('.') - 3] =~ '\K'
"        \ && getline('.')[col('.') - 2] =~ '\K' " last char
"        \ && getline('.')[col('.') - 1] !~ '\K'
"
"        call feedkeys("\<C-P>", 'n')
"    end
"endfun
"
