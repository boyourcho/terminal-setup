# ── Homebrew ──────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Editor ───────────────────────────────────────────────────────────────────
export EDITOR="hx"
export VISUAL="hx"

# ── History ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # share across sessions
setopt HIST_IGNORE_ALL_DUPS   # no duplicates
setopt HIST_REDUCE_BLANKS     # trim whitespace
setopt HIST_IGNORE_SPACE      # skip commands starting with space

# ── Completion ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select                    # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# ── Aliases ──────────────────────────────────────────────────────────────────
alias ls="eza -lah --git --icons"
alias ll="eza -lah --git --icons"
alias la="eza -a --icons"
alias tree="eza --tree --icons"
alias cat="bat"
alias grep="rg"
alias du="dust"
alias df="duf"
alias top="btop"

# Git shortcuts
alias gco="git checkout"
alias gst="git status -sb"
alias glg="git log --oneline --graph --decorate -n 20"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias lg="lazygit"

# ── Tool integrations ───────────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"

# fzf key bindings and completion
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ── Plugins ──────────────────────────────────────────────────────────────────
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null

# ── Zellij auto-attach ───────────────────────────────────────────────────────
if [[ -z "$ZELLIJ" ]] && command -v zellij &>/dev/null && [[ -o interactive ]]; then
    zellij attach -c main
fi

# ── Local overrides (not tracked in git) ─────────────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
