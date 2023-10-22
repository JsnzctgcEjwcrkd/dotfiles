#! /bin/bash

# node
curl https://get.volta.sh | bash
source ~/.zshrc
volta install node
node -v

# nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
./nvim.appimage --appimage-extract
rm -rf ./nvim.appimage
./squashfs-root/AppRun --version
  # Optional: exposing nvim globally.
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +slient +VimEnter +PlugInstall +qall

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

# vim-commentary
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/commentary.git
nvim +"helptags commentary/doc" +qall

# coc.nvim
nvim --headless +"CocInstall -sync coc-python|qa"

# vim-go
git clone https://github.com/fatih/vim-go.git ~/.local/share/nvim/site/pack/plugins/start/vim-go