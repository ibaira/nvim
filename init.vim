set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.vimrc

" Vim Plug
source $HOME/.config/nvim/vim-plug/plugins.vim

" Settings
source $HOME/.config/nvim/general/basic.vim
source $HOME/.config/nvim/general/filetypes.vim
source $HOME/.config/nvim/general/keybindings.vim
source $HOME/.config/nvim/general/settings.vim

" Theme
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/theme-config.vim

" Plugins
source $HOME/.config/nvim/plugins/airline.vim
source $HOME/.config/nvim/plugins/ale.vim
source $HOME/.config/nvim/plugins/coc.vim
source $HOME/.config/nvim/plugins/ctrlp.vim
source $HOME/.config/nvim/plugins/gitgutter.vim
source $HOME/.config/nvim/plugins/goyo.vim
source $HOME/.config/nvim/plugins/hexokinase.vim
source $HOME/.config/nvim/plugins/jedi.vim
source $HOME/.config/nvim/plugins/lazygit.vim
source $HOME/.config/nvim/plugins/ncm2.vim
source $HOME/.config/nvim/plugins/nerdtree.vim
source $HOME/.config/nvim/plugins/quickscope.vim
source $HOME/.config/nvim/plugins/rainbow.vim
source $HOME/.config/nvim/plugins/vim-commentary.vim
source $HOME/.config/nvim/plugins/vim-go.vim
source $HOME/.config/nvim/plugins/vimspector.vim