" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
     "Theming Plugins
     "Funcionality Plugins
	Plug 'preservim/nerdtree'
	Plug 'Shougo/deoplete.nvim'
     "Latex Plugins
	Plug 'lervag/vimtex'
	Plug 'jiangmiao/auto-pairs'
     "HTML Plugins
	Plug 'alvan/vim-closetag'

call plug#end()
