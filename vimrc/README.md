# Myvimrc
* Keep my newest version of vimrc
* Add Vim Plugin : Bundle
* Already Check all the configurations

# Install 

    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ git clone https://github.com/mudongliang/Myvimrc
    $ cp Myvimrc/vimrc ~/.vimrc
    $ rm -rf Myvimrc

# Brief Help

    :PluginUpdate	- update all the plugins
    :PluginList		- list configured plugins
    :PluginInstall	- install (update) plugins
    :PluginSearch	- search (or refresh cache first) for foo
    :PluginClean	- confirm (or auto-approve) removal of unused plugins

# Installed Plugins

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
 
    " Code complete
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'

    " Keep my own coding style
    Plugin 'mudongliang/vim-snippets'

    " NERD tree
    Plugin 'scrooloose/nerdtree'

    " Plugin to manage Most Recently Used (MRU) files
    Plugin 'mru.vim'
