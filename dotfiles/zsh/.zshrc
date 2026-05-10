# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# its empty because I use `Starship`
ZSH_THEME=""

plugins=(
  git
  sudo
  extract
  web-search
  copypath
  colored-man-pages
  history
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
)

# Start Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Start Starship; always at the bottom
eval "$(starship init zsh)"