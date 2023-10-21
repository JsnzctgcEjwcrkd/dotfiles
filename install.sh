#! /bin/bash
cd "$(dirname "$0")" || exit
SCRIPT_PATH=$(pwd)

sudo apt-get update
sudo apt-get -y upgrade

# zsh
sudo apt-get -y install zsh
chsh -s /bin/zsh

# create link
ln -s "$SCRIPT_PATH"/.zshrc ~
ln -s "$SCRIPT_PATH"/.p10k.zsh ~

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k