### Neovim & Windows Terminal Dotfiles

This repository contains a native, performance-oriented configuration for Neovim and Windows Terminal.

---

### Requirements

#### 1. Font

* **BlexMono Nerd Font Mono**
* Download and install `BlexMono Nerd Font Mono Windows Compatible` from [Nerd Fonts](https://www.nerdfonts.com/).

#### 2. Language Servers (LSP)

Ensure the following binaries are in your Windows PATH:

* **Go:** `go install golang.org/x/tools/gopls@latest`
* **Python:** `pip install pyright`

#### 3. Search Tools

Recommended for high-speed file searching:

* `ripgrep`
* `fd`

---

### Setup Instructions

#### Neovim

Copy `init.lua` from this repository to your local Neovim configuration directory:

1. Open File Explorer.
2. Navigate to `%LOCALAPPDATA%\nvim\` (typically `C:\Users\<User>\AppData\Local\nvim\`).
3. Paste `init.lua` here. If the `nvim` folder does not exist, create it.

#### Windows Terminal

1. Open Windows Terminal.
2. Open **Settings** (`Ctrl + ,`).
3. Click **Open JSON file** at the bottom left.
4. Copy the `schemes`, `actions`, and `defaults` sections from the `settings.json` in this repo and replace the corresponding sections in your local JSON file.

---

### Key Mappings

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle File Explorer (Netrw) |
| `jk` | Escape Insert Mode |
| `gd` | Go to Definition (LSP) |
| `K` | Hover Documentation (LSP) |
| `<leader>rn` | Rename Symbol (LSP) |
| `<leader>h` | Clear Search Highlights |
| `J` / `K` | Move selected lines (Visual Mode) |

