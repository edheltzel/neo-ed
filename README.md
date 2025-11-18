<h1 id="to-the-top">NEO.ED - Neovim Configuration</h1>

> [!NOTE]
> This is a git submodule of [edheltzel/dotfiles](https://github.com/edheltzel/dotfiles). The standalone repository is available at [github.com/edheltzel/neoed](https://github.com/edheltzel/neoed)

### My LazyVim-based Neovim setup for modern development

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

A carefully crafted Neovim configuration built on [LazyVim](https://www.lazyvim.org/), featuring extensive customizations, language support, and AI-powered tooling.

> [!WARNING]
> This is my personal Neovim setup and <ins>**changes often**</ins>. It's designed for my workflow and preferences. Feel free to get **inspired**, take what you want, and leave the rest to make it your own.

Table of Contents:

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration Structure](#configuration-structure)
- [Key Bindings](#key-bindings)
- [Plugin Highlights](#plugin-highlights)
- [Language Support](#language-support)
- [Theme & UI](#theme--ui)
- [AI Integration](#ai-integration)
- [Troubleshooting](#troubleshooting)

<h2 id="features">Features <a href="#to-the-top">↑</a></h2>

- **LazyVim Foundation** - Built on LazyVim for a modern, modular setup
- **AI-Powered Coding** - Claude Code + Supermaven integration
- **Multi-Language Support** - Go, Python, Rust, TypeScript, PHP, and more
- **Custom Keybindings** - Vim motions with modern IDE shortcuts
- **Performance Optimized** - Lazy loading and minimal startup time
- **Beautiful UI** - Eldritch theme with custom Lualine statusline
- **Git Integration** - LazyGit, Gitsigns, and GitHub CLI
- **Modal Editing** - Extensive custom keybindings for efficient editing

<h2 id="prerequisites">Prerequisites <a href="#to-the-top">↑</a></h2>

- Neovim >= 0.9.0
- Git >= 2.19.0
- A [Nerd Font](https://www.nerdfonts.com/) (recommended: JetBrainsMono Nerd Font)
- ripgrep (for Telescope)
- fd (for file finding)
- Node.js >= 18.0.0 (for LSP servers)
- A terminal with true color support

**For the full dotfiles setup:**
```shell
cd ~/.dotfiles && make stow pkg=nvim
```

<h2 id="installation">Installation <a href="#to-the-top">↑</a></h2>

<details>
  <summary><strong>As part of dotfiles (recommended)</strong></summary>

This configuration is managed as a git submodule in my dotfiles. To install:

1. Clone dotfiles with submodules:
   ```shell
   git clone --recurse-submodules https://github.com/edheltzel/dotfiles.git ~/.dotfiles
   ```

2. Stow the nvim package:
   ```shell
   cd ~/.dotfiles
   make stow pkg=nvim
   ```

3. Launch Neovim and let lazy.nvim install plugins:
   ```shell
   nvim
   ```

</details>

<details>
  <summary><strong>Standalone installation</strong></summary>

If you want to use this configuration standalone (outside of the dotfiles):

1. Backup your existing Neovim configuration:
   ```shell
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. Clone this repository:
   ```shell
   git clone https://github.com/edheltzel/neoed.git ~/.config/nvim
   ```

3. Launch Neovim:
   ```shell
   nvim
   ```

</details>

<h2 id="configuration-structure">Configuration Structure <a href="#to-the-top">↑</a></h2>

The configuration follows a modular architecture for maintainability:

```
lua/
├── config/                # Core configuration
│   ├── lazy.lua          # Plugin manager bootstrap
│   ├── options.lua       # Vim options
│   ├── keymaps.lua       # Custom keybindings
│   └── autocmds.lua      # Autocommands
└── plugins/               # Plugin configurations
    ├── colorscheme.lua   # Theme configuration
    ├── lualine.lua       # Statusline
    ├── snacks.lua        # UI enhancements
    ├── supermaven.lua    # AI completion
    ├── languages/        # Language-specific configs
    │   ├── go.lua
    │   ├── python.lua
    │   ├── rust.lua
    │   └── typescript.lua
    └── themes/           # Custom themes
        └── lualine/
            └── neoed.lua # Custom statusline theme
```

<h2 id="key-bindings">Key Bindings <a href="#to-the-top">↑</a></h2>

Leader key: `<Space>`

### General

| Key | Action |
|-----|--------|
| `jj` / `jk` | Exit INSERT mode |
| `U` | Redo (shift+u) |
| `<C-a>` | Select all |
| `gh` / `gl` | Jump to beginning/end of line |
| `<Alt-j/k>` | Move lines up/down |
| `<Enter>` | Toggle code folding |

### File & Window Management

| Key | Action |
|-----|--------|
| `<leader>fs` | Save file |
| `<C-h/j/k/l>` | Navigate splits |
| `<C-`>` | Toggle terminal |

### AI/Claude Code (`<leader>a`)

| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` | Resume Claude |
| `<leader>ab` | Add current buffer to context |
| `<leader>aa` | Accept diff |
| `<leader>ad` | Deny diff |

### Search/Navigation

| Key | Action |
|-----|--------|
| `<leader>jj` | Flash jump (leap to character) |
| `<C-n>` | Multi-word editing |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit (borderless) |

<h2 id="plugin-highlights">Plugin Highlights <a href="#to-the-top">↑</a></h2>

- **lazy.nvim** - Modern plugin manager with lazy loading
- **LazyVim** - Neovim configuration framework
- **Telescope** - Fuzzy finder for files, buffers, and more
- **nvim-treesitter** - Syntax highlighting and code parsing
- **nvim-lspconfig** - LSP configuration for language servers
- **which-key** - Keybinding discovery and documentation
- **flash.nvim** - Enhanced navigation and search
- **LazyGit** - Git integration with TUI
- **snacks.nvim** - UI enhancements and utilities

<h2 id="language-support">Language Support <a href="#to-the-top">↑</a></h2>

The following languages are configured with LSP, formatting, and linting:

**Core Languages:**
- Go (gopls, gofumpt, staticcheck)
- Python (pyright, ruff)
- Rust (rust-analyzer)
- TypeScript/JavaScript (typescript-language-server, biome)
- PHP (intelephense)

**Frontend:**
- Astro
- Svelte
- Vue

**Config/Data:**
- Docker
- Helm
- YAML
- TOML
- JSON
- Markdown

<h2 id="theme--ui">Theme & UI <a href="#to-the-top">↑</a></h2>

- **Colorscheme:** Eldritch
- **Statusline:** Custom Lualine with neo.ed theme
- **Icons:** Nerd Font icons throughout
- **Transparency:** Optional background transparency support

The UI is designed to be clean, distraction-free, and aesthetically pleasing while remaining functional.

<h2 id="ai-integration">AI Integration <a href="#to-the-top">↑</a></h2>

This configuration includes two AI-powered tools:

1. **Claude Code** - AI pair programmer with deep codebase understanding
   - Toggle with `<leader>ac`
   - Add context with `<leader>ab`
   - Accept/deny diffs with `<leader>aa`/`<leader>ad`

2. **Supermaven** - AI code completion
   - Real-time inline suggestions
   - Context-aware completions

<h2 id="troubleshooting">Troubleshooting <a href="#to-the-top">↑</a></h2>

<details>
  <summary>Plugins not loading</summary>

Try removing the lazy.nvim cache:

```shell
rm -rf ~/.local/share/nvim
nvim
```

Then restart Neovim and run `:Lazy sync`.

</details>

<details>
  <summary>LSP not working</summary>

Check if the language server is installed:

```shell
:LspInfo
```

Install missing servers with Mason:

```shell
:Mason
```

</details>

<details>
  <summary>Treesitter errors</summary>

Update treesitter parsers:

```shell
:TSUpdate
```

Or install specific parser:

```shell
:TSInstall <language>
```

</details>

<details>
  <summary>Git submodule issues</summary>

If this configuration is out of sync as a submodule:

```shell
cd ~/.dotfiles/nvim/.config/nvim
git pull origin master
cd ~/.dotfiles
git add nvim/.config/nvim
git commit -m "Update neoed submodule"
```

</details>

<details>
  <summary>Performance issues</summary>

Check startup time:

```shell
nvim --startuptime startup.log
```

Disable plugins temporarily by commenting them out in `lua/plugins/`.

</details>

---

<p align="center">Built with ❤️ by <a href="https://github.com/edheltzel">@edheltzel</a></p>
