source $HOME/.config/nvim/vim-plug/plugins.vim

let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'

" Custom Keybindings

nnoremap zz :w!<cr>
nnoremap zx :wq<cr>
nnoremap zc :q!<cr>
nnoremap ft :NERDTreeToggle<CR>

" Auto Completion

filetype plugin on
set omnifunc=syntaxcomplete#Complete
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

