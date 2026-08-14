# Completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# PATH
export PATH="$HOME/.local/bin:$PATH"
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias v='nvim'

# ssh-agent — start automatisk hvis ikke kørende
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" > /dev/null
  ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# Starship prompt
eval "$(starship init zsh)"

# FZF
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# FZF — brug fd til at finde filer og bat til preview
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=right:50%'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range :200 {}"'
export FZF_ALT_C_OPTS='--preview "ls --color=always {}"'

# fe — fuzzy find og åbn i nvim
fe() {
  local file
  file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always --line-range :200 {}') && nvim "$file"
}

# Clipboard (Wayland)
export CLIPBOARD=wl-clipboard

# zsh-autosuggestions
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#4C566A'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# zsh-syntax-highlighting (skal være sidst)
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- AI (aktiver når Ollama er sat op) ---
# export AI_CMD_BACKEND="ollama"
# export AI_CMD_OLLAMA_MODEL="qwen2.5-coder:7b"
# source ~/.zsh/ai-cmd/ai-cmd.plugin.zsh

# npm globale pakker (bruger-prefix, ingen sudo)
export PATH="$HOME/.npm-global/bin:$PATH"



export PATH="$HOME/.local/share/pi-node/node-v22.23.2-linux-x64/bin:$PATH"
