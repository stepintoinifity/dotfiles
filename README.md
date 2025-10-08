# My dotfiles

dotfiles directory located at `$HOME/`.

use gnu stow to create a soft link from dotfile configures.

for example
```
cd $HOME/dotfiles && stow tmux -t ~
```

# Zsh
```
stow zsh -t ~ && source ~/.zshrc
```

# Tmux

```
stow tmux -t ~ && tmux source ~/.tmux.conf
```
