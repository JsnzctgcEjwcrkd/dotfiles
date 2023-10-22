#! /bin/bash
cd "$(dirname "$0")" || exit
SCRIPT_PATH=$(pwd)

sudo apt-get update
sudo apt-get -y upgrade

# python
sudo apt-get -y install python3 python3-pip
pip3 install pylint jedi

# zsh
sudo apt-get -y install zsh
chsh -s /bin/zsh

# create link
ln -s "$SCRIPT_PATH"/.zshrc ~
ln -s "$SCRIPT_PATH"/.p10k.zsh ~
mkdir -p ~/.config/nvim/
ln -s "$SCRIPT_PATH"/init.vim ~/.config/nvim/
ln -s "$SCRIPT_PATH"/.tmux.conf ~

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

# autojump
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
rm -rf autojump

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
