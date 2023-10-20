#! /bin/bash
sudo apt-get update
sudo apt-get -y upgrade

# python
sudo apt-get -y install python3 python3-pip
pip3 install pylint jedi

# zsh
sudo apt-get -y install zsh
chsh -s /bin/zsh
sudo su $USER
zsh --version
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
cp ./zshrc ~/.zshrc
cp ./p10k.zsh ~/.p10k.zsh
source ~/.zshrc

# node used by coc.nvim
curl https://get.volta.sh | bash
source ~/.zshrc
volta install node
node -v

# screen
sudo apt-get -y install screen
screen -v

# tmux
sudo apt-get -y install tmux
tmux -V

# vim
sudo apt-get -y install vim
vim --version

# NVIM
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim --version
# add config
mkdir -p ~/.config/nvim/
INIT_VIM=~/.config/nvim/init.vim
touch $INIT_VIM
echo 'set shell=/bin/zsh' >> $INIT_VIM
echo 'set shiftwidth=4' >> $INIT_VIM
echo 'set tabstop=4' >> $INIT_VIM
echo 'set expandtab' >> $INIT_VIM
echo 'set textwidth=0' >> $INIT_VIM
echo 'set autoindent' >> $INIT_VIM
echo 'set hlsearch' >> $INIT_VIM
echo 'set clipboard=unnamed' >> $INIT_VIM
echo 'syntax on' >> $INIT_VIM

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo -e '\n' >> $INIT_VIM
echo '" vim-plug' >> $INIT_VIM
echo 'call plug#begin()' >> $INIT_VIM
  # plugin
  echo "Plug 'ntk148v/vim-horizon'" >> $INIT_VIM
  echo "Plug 'preservim/nerdtree'" >> $INIT_VIM
  echo "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }" >> $INIT_VIM
  echo "\"Plug 'sheerun/vim-polyglot'" >> $INIT_VIM
  echo "Plug 'neoclide/coc.nvim', {'branch': 'release'}" >> $INIT_VIM
echo 'call plug#end()' >> $INIT_VIM
nvim +slient +VimEnter +PlugInstall +qall

# vim-horizon settings
echo -e '\n' >> $INIT_VIM
echo '" vim-horizon settings' >> $INIT_VIM
echo '" if you don'\''t set this option, this color might not correct' >> $INIT_VIM
echo '"set termguicolors' >> $INIT_VIM
echo '"colorscheme horizon' >> $INIT_VIM
echo '" lightline' >> $INIT_VIM
echo '"let g:lightline = {}' >> $INIT_VIM
echo '"let g:lightline.colorscheme = '\''horizon'\''"' >> $INIT_VIM

# NERDTree settings
echo -e '\n' >> $INIT_VIM
echo '" NERDTree settings' >> $INIT_VIM
echo '"nnoremap <C-n> :NERDTree<CR>' >> $INIT_VIM
echo '" Start NERDTree when Vim is started without file arguments.' >> $INIT_VIM
echo "autocmd StdinReadPre * let s:std_in=1" >> $INIT_VIM
echo 'autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif' >> $INIT_VIM

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
source ~/.zshrc

# vim-fugitive
mkdir -p ~/.config/nvim/pack/tpope/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
nvim +"helptags fugitive/doc" +qall

# vim-gitgutter
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git
nvim +"helptags vim-gitgutter/doc" +qall
echo -e '\n' >> $INIT_VIM
echo '" vim-gitgutter settings' >> $INIT_VIM
echo "let g:gitgutter_highlight_lines = 1" >> $INIT_VIM

# vim-commentary
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/commentary.git
nvim +"helptags commentary/doc" +qall

# coc.nvim
nvim --headless +"CocInstall -sync coc-python|qa"

# vim-go
git clone https://github.com/fatih/vim-go.git ~/.local/share/nvim/site/pack/plugins/start/vim-go