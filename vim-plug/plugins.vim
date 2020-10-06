" Vim-plug list of plugins

call plug#begin('~/.vim/plugged')

Plug 'majutsushi/tagbar'  " show tags in a bar (functions etc) for easy browsing
Plug 'vim-airline/vim-airline'  " make statusline awesome
Plug 'vim-airline/vim-airline-themes'  " themes for statusline
Plug 'davidhalter/jedi-vim'   " jedi for python
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'tweekmonster/impsort.vim'  " color and sort imports
Plug 'wsdjeg/FlyGrep.vim'  " awesome grep on the fly
Plug 'w0rp/ale'  " python linters
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter
Plug 'tpope/vim-commentary'  "comment-out by gc
Plug 'roxma/nvim-yarp'  " dependency of ncm2
Plug 'neoclide/coc.nvim'  " Conquer of Completion
Plug 'tpope/vim-fugitive'  " Git integration
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }  
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Powerful fuzzy search
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'  " Start window with quotes and shortcuts
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Golang autocomplete
Plug 'RRethy/vim-hexokinase'  " Display color codes
Plug 'sheerun/vim-polyglot'  " Better syntax highlight
Plug 'junegunn/goyo.vim'  " View mode without distractions
Plug 'easymotion/vim-easymotion'  " Fast movements
Plug 'tpope/vim-surround'  " Surround elements
Plug 'luochen1990/rainbow'  " Rainbow brackets
Plug 'puremourning/vimspector'  " Multi language graphical debugger
Plug 'unblevable/quick-scope'  " Highligh characters when searching horizontaly
Plug 'honza/vim-snippets'  " Snippets
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'OmniSharp/omnisharp-vim'  " C# utility
Plug 'michaeljsmith/vim-indent-object'  " Indent object
Plug 'sainnhe/gruvbox-material'  " More readable version of the GruvBox theme
Plug 'jiangmiao/auto-pairs'  " Auto close brackets
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}  " Fast file system explorer
Plug 'ryanoasis/vim-devicons'  " Developer icons used by chadtree, airline, etc

call plug#end()
