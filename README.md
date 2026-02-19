# macOS Terminal Setup

A clean, modern terminal environment for macOS, designed to be consistent across multiple Macs.

## Stack

**Ghostty** (terminal) → **Zsh + Starship** (shell + prompt) → **Zellij** (multiplexer)

## Modern CLI Tools

| Instead of | Use     | Why                          |
|------------|---------|------------------------------|
| `ls`       | `eza`   | Icons, colors, git-aware     |
| `cat`      | `bat`   | Syntax highlighting          |
| `find`     | `fd`    | Faster, simpler syntax       |
| `grep`     | `rg`    | Ripgrep — blazing fast       |
| `cd`       | `z`     | Zoxide — learns your habits  |
| `diff`     | `delta` | Beautiful git diffs          |
| `man`      | `tldr`  | Community-maintained cheat sheets |

## Quick Start

```bash
git clone https://github.com/boyourcho/terminal-setup.git ~/Desktop/terminal-setup
cd ~/Desktop/terminal-setup
./setup.sh
```

Then restart Ghostty.

## Files

```
├── Brewfile              # All packages (brew bundle install)
├── .zshrc                # Shell configuration → ~/.zshrc
├── starship.toml         # Prompt config → ~/.config/starship.toml
├── ghostty/config        # Terminal config → ~/.config/ghostty/config
├── zellij/config.kdl     # Multiplexer config → ~/.config/zellij/config.kdl
├── setup.sh              # Bootstrap script (runs everything)
└── README.md
```

## Key Bindings

### Zsh / fzf

| Key       | Action                          |
|-----------|---------------------------------|
| `Ctrl+T`  | Fuzzy find files                |
| `Ctrl+R`  | Fuzzy search command history    |
| `Alt+C`   | Fuzzy cd into directories       |
| `Tab`     | Completions with arrow-key menu |

### Zellij (default leader: `Ctrl+g`)

| Key             | Action                   |
|-----------------|--------------------------|
| `Ctrl+g` then `n` | New pane               |
| `Ctrl+g` then `t` | New tab                |
| `Alt+←/→`       | Switch tabs              |
| `Alt+↑/↓`       | Switch panes             |
| `Ctrl+g` then `d` | Detach session         |

Full reference: `zellij help` or [zellij.dev/documentation](https://zellij.dev/documentation/)

## Customization

**Prompt:** Edit `starship.toml`. See [starship.rs/config](https://starship.rs/config/) for all options.

**Packages:** Add to `Brewfile` and run `brew bundle install`.

**Local overrides:** Create `~/.zshrc.local` for machine-specific config (not tracked in git).

## Claude Code

Claude Code requires a Claude Pro, Max, or API billing account.

```bash
claude         # start interactive session
claude "query" # one-shot query
```
