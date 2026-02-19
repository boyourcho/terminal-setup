#!/bin/bash
# Bootstrap a clean macOS terminal environment.
# Idempotent — safe to re-run.
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Terminal Setup"
echo "    Source: $DOTFILES_DIR"
echo ""

# ── 1. Homebrew ──────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "==> Homebrew already installed"
fi

# ── 2. Packages ──────────────────────────────────────────────────────────────
echo ""
echo "==> Installing packages from Brewfile..."
brew bundle install --file="$DOTFILES_DIR/Brewfile"

# ── 3. Symlinks ──────────────────────────────────────────────────────────────
echo ""
echo "==> Symlinking config files..."

link() {
    local src="$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        # Already a symlink — update it
        rm "$dst"
    elif [ -f "$dst" ]; then
        # Existing file — back it up
        echo "    Backed up $dst → ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -s "$src" "$dst"
    echo "    $dst → $src"
}

link "$DOTFILES_DIR/.zshrc"          "$HOME/.zshrc"
link "$DOTFILES_DIR/starship.toml"   "$HOME/.config/starship.toml"
link "$DOTFILES_DIR/ghostty/config"  "$HOME/.config/ghostty/config"
link "$DOTFILES_DIR/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

# ── 4. fzf key bindings ─────────────────────────────────────────────────────
echo ""
echo "==> Setting up fzf..."
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null
    echo "    fzf key bindings installed"
fi

# ── 5. tldr cache ────────────────────────────────────────────────────────────
if command -v tldr &>/dev/null; then
    echo ""
    echo "==> Updating tldr cache..."
    tldr --update 2>/dev/null || true
fi

# ── 6. Done ──────────────────────────────────────────────────────────────────
echo ""
echo "==> Done!"
echo ""
echo "    Restart Ghostty to pick up the new config."
echo "    Your old configs were backed up with .bak extension."
echo ""
echo "    Stack: Ghostty → Zsh + Starship → Zellij"
echo ""
