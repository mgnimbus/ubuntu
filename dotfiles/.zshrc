# Brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export AWS_PROFILE=obsrv
alias obsrv='export AWS_PROFILE=obsrv'
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

# Load completions
autoload -Uz compinit && compinit

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#export EDITOR="code --wait"
# git
alias c='clear'
alias gc='git clone'
alias gch='git branch'
alias gs='git status'
alias vi='code'
alias k='kubectl'
alias ks='kubectl get ns'
alias ko='kubectl get node'
alias kp='kubectl get pod -A'
alias kgp='kubectl get po -n '
alias kdpm='kubectl describe po -n mimir'
alias kdp='kubectl describe po -n '
alias kdpl='kubectl describe po -n loki'
alias kdpt='kubectl describe po -n tempo'
alias kdpg='kubectl describe po -n grafana'
alias kgpm='kubectl get po -n mimir'
alias kgpl='kubectl get po -n loki'
alias kgpt='kubectl get po -n tempo'
alias kgpg='kubectl get po -n grafana'
alias kgpn='kubectl get po -n'
alias kno='kubectl get node'
alias kc='aws eks update-kubeconfig --region us-east-1 --name'
alias pnr='kubectl get pods --all-namespaces --field-selector=status.phase!=Running'

alias ti='terraform init'
alias tp='terraform plan'
alias ta='terraform apply'
alias taa='terraform apply --auto-approve'
alias to='terraform output'
alias td='terraform destroy'
alias tdd='terraform destroy --auto-approve'

alias rt='rm -rf ./terraform .terraform.lock.hcl'

alias edit-zsh='code ~/.zshrc'
alias reload-zsh='source ~/.zshrc'
alias edit-star='code ~/.config/starship/starship.toml'
alias aws-crds='code /home/nimbus/.aws/credentials'
alias aws-conf='code /home/nimbus/.aws/configconfig'
alias edit-kube='code /home/nimbus/.kube/config'

# Set Kubernetes namespace context
alias ksetns='kubectl config set-context --current --namespace'

# Remove namespace context (reset to default)
alias kresetns='kubectl config set-context --current --namespace=""'

# Example usage:
# ksetns meta-monitoring   -> Sets namespace to meta-monitoring
# kresetns                 -> Resets to default namespace


# kubectl get namespace "meta-monitoring" -o json \
#   | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
#   | kubectl replace --raw /api/v1/namespaces/meta-monitoring/finalize -f -

# state lock removal

rm_tf_lock() {
  local TABLE_NAME="$1"
  local STATE_KEY="$2"

  if [[ -z "$TABLE_NAME" || -z "$STATE_KEY" ]]; then
    echo "Usage: rm_tf_lock <dynamodb-table-name> <terraform-state-key>"
    return 1
  fi

  echo "Removing Terraform state lock for Key: $STATE_KEY from table: $TABLE_NAME..."

  # Delete the lock entry
  aws dynamodb delete-item \
    --table-name "$TABLE_NAME" \
    --key "{\"LockID\": {\"S\": \"$STATE_KEY\"}}" \
    --output json

  echo "Terraform lock for '$STATE_KEY' removed successfully."
}

# Usage:
# rm_tf_lock <dynamodb-table-name> <terraform-state-key>



# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"


# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

export BAT_THEME=tokyonight_night

# ---- Eza (better ls) -----

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"


# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"































source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh