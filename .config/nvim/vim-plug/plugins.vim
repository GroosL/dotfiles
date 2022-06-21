" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'Shougo/deoplete.nvim'
	Plug 'sheerun/vim-polyglot'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
	Plug 'lervag/vimtex'
	Plug 'jiangmiao/auto-pairs'
	Plug 'alvan/vim-closetag'
	Plug 'folke/tokyonight.nvim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'ajh17/vimcompletesme'
    Plug 'davidhalter/jedi-vim'
    Plug 'morhetz/gruvbox'
    Plug 'shaunsingh/nord.nvim'
"    Plug 'github/copilot.vim'
    Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
    Plug 'Chiel92/vim-autoformat'
    Plug 'dracula/vim'
call plug#end()
