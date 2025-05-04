#!/bin/bash


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change zsh theme to agnoster
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' .zshrc
### Command to test differnet way to modify the ohmyzsh plugins
## sed -i 's/plugins=(git)/plugins=(git\nautojump\ncolored-man-pages\ncolorize\ncopyfile\ncopypath\nfzf\neza)/'
sed -i 's/plugins=(git)/plugins=(git colored-man-pages colorize copyfile copypath fzf eza)/' ~/.zshrc

# Added for ohmyzsh fzf plugin
echo "export FZF_BASE=~/.fzf" >> ~/.zshrc

# Install fzf via github
git clone --depth 1 https://github.com/junegunn/fzf.git
cd ~/fzf
./install --all
cd ~/
