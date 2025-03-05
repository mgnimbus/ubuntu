
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Aliases
alias ls='ls --color'
alias vi='code'
alias c='clear'
alias k='kubectl'

alias edit-zsh='code ~/.zshrc'
alias reload-zsh='source ~/.zshrc'
alias edit-star='code ~/.config/starship/starship.toml'
alias reload-star='source ~/.config/starship/starship.toml'


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"