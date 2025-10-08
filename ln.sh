#!/bin/bash

if [ ! -e "/home/${USER}/.config/" ]; then
    mkdir "/home/${USER}/.config/"
fi

cd /home/${USER}/

echo "linking zsh..."
ln -sf /home/${USER}/OneDrive/dotfiles/zsh/.zshrc
ln -sf /home/${USER}/OneDrive/dotfiles/zsh/.aliases
ln -sf /home/${USER}/OneDrive/dotfiles/zsh/.oh-my-zsh

cd /home/${USER}/.config/

echo "linking nvim..."
ln -sf /home/${USER}/OneDrive/dotfiles/nvim

echo "linking zellij..."
ln -sf /home/${USER}/OneDrive/dotfiles/zellij

echo "linking ghosty..."
ln -sf /home/${USER}/OneDrive/dotfiles/ghostty

echo "finish."
