# ==============================================================================
# Core Zsh Controller
# ==============================================================================

# Define our dotfiles Zsh configuration path
# export ZSH_CONFIG_DIR="$HOME/.dotfiles/zsh"
# export ZSH_CONFIG_DIR="$HOME/.config/nixos-config/zsh"
export ZSH_CONFIG_DIR="~"

# 1. Load Environment Variables & Paths first
# if [[ -f "$ZSH_CONFIG_DIR/env.zsh" ]]; then
#   source "$ZSH_CONFIG_DIR/env.zsh"
# fi

# ==============================================================================
# System Environment & Executable Paths
# ==============================================================================

# Core Text Editors (Defaulting to Helix 'hx')
# export EDITOR="hx"

# export VISUAL="hx"

# AWS Configuration State
export AWS_PROFILE="CloudDevAdminTemp-851307004751"

# Constructing system PATH safely without duplicates
typeset -U path # Keeps PATH unique
path=(
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
    $path
)
export PATH

# 2. Advanced Autocompletion Engine Setup
# (Grouped together and ordered correctly for speed)
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Add local site-functions to fpath
fpath=(~/.local/share/zsh/site-functions/ $fpath)

# Third-party completions & hooks
complete -C $(which aws_completer) aws
if command -v terraform &>/dev/null; then
    complete -o nospace -C $(which terraform) terraform
fi
# source <(kubectl completion zsh) # Uncomment when needed

# 3. Interactive Shell Integrations & Keybindings
# The definitive 'Fancy Ctrl-Z' shortcut (background/foreground toggle)
fancy-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line -w
    else
        zle push-input -w
        zle clear-screen -w
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Plugins (Manual sources)
if [[ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 4. Load Aliases
# if [[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ]]; then
#   source "$ZSH_CONFIG_DIR/aliases.zsh"
# fi
# ==============================================================================
# Command Modifiers & Core Tool Aliases
# ==============================================================================

# Modern 'eza' alternatives for standard file listing
alias ls="eza --icons"
alias ll="eza -l --header --icons"
alias la="eza -la --header --icons"
alias tre="eza -T --icons"
alias edit="sudo -e"
alias upns="sudo nixos-rebuild switch --flake .#"

# Emacs Client shortcuts (Daemon mode orchestration)
alias emacs='emacsclient -a "" -t'
alias et="emacsclient -nw -a ''"

# Dotfiles Directory
alias dotnix="cd $HOME/.config/nixos-config"

# 5. Prompt & Environment Tool Hooks (Loaded last)
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
