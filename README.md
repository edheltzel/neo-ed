# NOE.ED

This is a my personal Neovim configuration. At its core is [LazyVim](https://github.com/LazyVim/LazyVim), with a few additional plugins, my theme of choice, a customized Lualine setup and my mediocre keybindings to try and match my Zed and VSCode setups. If you're curious about those, you can find them in my [dotfiles](https://github.com/edheltzel/dotfiles) - check it or not, get inspired use what you want leave the rest.

## TODO

- [ ] better AI tooling
- [ ] consider dropping snacks explorer for Yazi
- [ ] port more vscode/zed keybindings
- [ ] Add more language support for web development
- [ ] Improve UI and theme customizations
- [ ] Research more autocmds and filetype definitions
- [ ] Raycast integration (for MacOS)
- [ ] consider support for Omarchy (for hipster in me)
- [ ] improve on flash keybindings

## Prerequisites

Before installing NOE.ED, ensure you have the following:

- **Neovim** >= 0.11.0 (Recommended: latest stable version)
- **Git** >= 2.5.0
- **A Nerd Font** (e.g., [Nerd Font](https://www.nerdfonts.com/)) installed and configured in your terminal
- **ripgrep** (for telescope fuzzy finding): `brew install ripgrep` (MacOS) or equivalent
- **fd** (for faster file finding): `brew install fd` (MacOS) or equivalent
- **Node.js** >= 18.x (for LSP servers and tools)
- **Clipboard tool**: `pbcopy` (MacOS), `xclip` or `wl-clipboard` (Linux)
- **Lazygit** (for Git integration): `brew install lazygit`
- **Yazi** (for Explorer): `brew install yazi` (optional)

## Installation

### Fresh Installation

1. **Backup your existing Neovim configuration** (if you have one):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   mv ~/.local/state/nvim ~/.local/state/nvim.backup
   mv ~/.cache/nvim ~/.cache/nvim.backup
   ```

2. **Clone the repository**:

   ```bash
   git clone https://github.com/edheltzel/noe.ed.git ~/.config/nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

   On first launch, lazy.nvim will automatically:
   - Install itself
   - Download and install all plugins
   - Set up language servers

   This may take a few minutes. Wait for all plugins to install.

4. **Restart Neovim** to ensure all plugins are properly loaded.

### Post-Installation

1. **Install language servers** (if not already installed):

   Inside Neovim, run:

   ```vim
   :Mason
   ```

   Then install the LSP servers you need (they'll auto-install for most languages when you open a file).

2. **Check health**:

   ```vim
   :checkhealth
   ```

   This will identify any missing dependencies.

3. **Install additional language support**:

   ```vim
   :LazyExtras
   ```

   Browse and enable additional language packs and utilities.

## Usage

### Getting Started

- **Leader key**: `Space`
- **Save file**: `<leader>fs` or `:w`
- **Yazi**: `<leader>qq` or `:q`
- **Quit**: `<leader>qq` or `:q`

### Custom Dashboard

NOE.ED features a custom Snacks dashboard (lua/plugins/snacks.lua:27) with quick access shortcuts:

- `n` - New file
- `r` - Recent files
- `f` - Find file
- `g` - Find text (live grep)
- `o` - Find session
- `d` - Open DOTFILES directory (update this path snacks.lua)
- `v` - Open NOE.ED config (update this path see snacks.lua)
- `x` - LazyExtras menu
- `l` - Lazy plugin manager
- `q` - Quit

### Essential Keybindings

#### General

| Key | Mode | Description |
|-----|------|-------------|
| `U` | Normal | Redo |
| `<C-a>` | Normal | Select all |
| `gh` / `gl` | Normal | Jump to beginning/end of line |
| `<Alt-j/k>` or `<Alt-up/down>` | Normal/Visual | Move lines up/down |
| `<Alt-Ctrl-Up>` or `<Alt-Ctrl-d>` | Normal/Visual | Duplicate lines |
| `<Alt-Backspace>` | Insert/Command/Normal | Delete word (MacOS style) |
| `<Enter>` | Normal | Toggle code folding |
| `>` / `<` | Visual | Indent right/left and reselect |

#### File Management

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fs` | Normal | Save file |
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Live grep |
| `<leader>fr` | Normal | Recent files |
| `<leader>e` | Normal | File explorer |

#### Window Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `<C-h/j/k/l>` | Normal | Navigate between splits |
| `<leader>wv` | Normal | Split vertically |
| `<leader>wh` | Normal | Split horizontally |
| `<leader>wd` | Normal | Close window |

#### AI Tools

**Claude Code:**

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ac` | Normal | Toggle Claude Code |
| `<leader>af` | Normal | Focus Claude Code |
| `<leader>ar` | Normal | Resume Claude session |
| `<leader>aC` | Normal | Continue Claude session |
| `<leader>am` | Normal | Select Claude model |
| `<leader>ab` | Normal | Add current buffer to context |
| `<leader>as` | Visual | Send selection to Claude |
| `<leader>aa` | Normal | Accept diff |
| `<leader>ad` | Normal | Deny diff |

**OpenCode:**

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ao` | Normal | Launch/Toggle OpenCode |
| `<Ctrl-Alt-a>` | Normal/Visual | Ask OpenCode |
| `<Ctrl-Alt-x>` | Normal/Visual | Execute OpenCode action |
| `<Ctrl-Alt-g>` | Normal/Visual | Add to OpenCode |

**Supermaven:**

| Key | Mode | Description |
|-----|------|-------------|
| `<C-l>` | Insert | Accept suggestion |
| `<C-x>` | Insert | Clear suggestion |
| `<C-j>` | Insert | Accept word |

#### Search & Replace

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sr` | Normal | Search & Replace (GrugFar) |
| `<leader>nh` | Normal | Clear search highlights |
| `<C-n>` | Normal | Multi-word editing (use `.` to repeat) |

#### Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | Normal | LazyGit (borderless) |
| `<leader>gb` | Normal | Git blame line |
| `<leader>gd` | Normal | Git diff |

**Git Features:**

- Inline current line blame (gitsigns)
- Toggle-able signs for changes
- Integrated LazyGit with borderless UI

#### Terminal

| Key | Mode | Description |
|-----|------|-------------|
| `<C-`>` | Normal/Terminal | Toggle terminal (borderless) |
| `<Esc>` | Terminal | Exit terminal mode to Normal mode |

#### Code Navigation

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Find references |
| `K` | Normal | Hover documentation |

### Configuration Structure

So the plugin directory is structured, to match the LazyVim docs.

```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Vim options
│   │   ├── keymaps.lua   # Custom keybindings
│   │   ├── autocmds.lua  # Autocommands
│   │   └── filetypes.lua # Custom filetype definitions
│   └── plugins/
│       ├── ai/           # AI tool configurations
│       │   ├── claudecode.lua
│       │   ├── opencode.lua
│       │   └── supermaven.lua
│       ├── coding/       # Coding utilities
│       │   └── surround.lua
│       ├── editor/       # Editor enhancements
│       │   ├── explorer.lua
│       │   ├── neotree.lua
│       │   └── search.lua
│       ├── formatting/   # Code formatting
│       │   └── conform.lua
│       ├── languages/    # Language-specific configs
│       │   ├── go.lua
│       │   └── jinja.lua
│       ├── ui/           # UI and theme customizations
│       │   ├── colorscheme.lua
│       │   ├── eldritch.lua
│       │   ├── lualine.lua
│       │   └── lualine/
│       │       ├── eldritch.lua
│       │       └── neoed.lua
│       ├── utils/        # Utility plugins
│       │   └── snacks.lua
│       └── disabled.lua  # Disabled plugins
├── .neoconf.json         # Neoconf settings
├── codebook.toml         # Codebook dictionary
├── lazyvim.json          # LazyVim extras configuration
├── lazy-lock.json        # Plugin version lockfile
├── stylua.toml           # Lua formatter config
└── CLAUDE.md             # Claude Code instructions
```

### Enabled LazyVim Extras

This configuration includes the following LazyVim extras (from lazyvim.json:1):

**AI & Coding:**

- Claude Code integration
- Supermaven AI completion
- Mini-surround for text objects
- DAP (Debug Adapter Protocol) core

**Languages:**

- PHP, Python, Go, Rust, Helm
- Docker, Fish
- Tailwind CSS, Astro, Svelte, Vue, Nunjucks/Twig/Jinja/Django
- JavaScript/TypeScript, YAML, TOML, JSON, Markdown

**Editor & Utilities:**

- Yazi file manager
- Mini-files file manager
- Snacks explorer & picker
- Biome formatting
- GitHub CLI integration
- Mini-hipatterns
- REST client

## Customization

See [LazyVim documentation](https://lazyvim.github.io/configuration/#plugins) for more information.

### Changing Colorscheme

Edit `lua/plugins/themes/colorscheme.lua`:

```lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "your-preferred-theme",
    },
  },
}
```

The current colorscheme is **Eldritch** with custom configuration (lua/plugins/themes/eldritch.lua:1):

- Dim inactive windows enabled
- Dark sidebars and floats
- Non-transparent background

### Disabling Plugins

Add to `lua/plugins/disabled.lua`:

```lua
return {
  { "plugin/name", enabled = false }
}
```

## Key Plugin Configurations

### AI Integrations

**Claude Code** (lua/plugins/ai.lua:27): Official Anthropic integration for Neovim

- Full conversation context management
- Diff preview and acceptance workflow
- Model selection support

**Supermaven** (lua/plugins/ai.lua:2): AI-powered code completion

- Custom keybindings for suggestion management
- Configurable inline completion
- Filetype ignoring support

## Troubleshooting

### Plugins not loading

1. Remove plugin cache:

   ```bash
   rm -rf ~/.local/share/nvim
   rm -rf ~/.local/state/nvim
   ```

2. Restart Neovim and reinstall:

   ```vim
   :Lazy sync
   ```

### LSP not working

1. Check Mason:

   ```vim
   :Mason
   ```

2. Check health:

   ```vim
   :checkhealth
   ```

3. Manually install LSP server:

   ```vim
   :MasonInstall <server-name>
   ```

### Keybindings not working

Ensure you're in the correct mode (Normal, Insert, Visual). Check which-key for available bindings:

```vim
<leader>  (press space and wait)
```

## Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)

## Acknowledgments

Built on top of [LazyVim](https://github.com/LazyVim/LazyVim) by [@folke](https://github.com/folke).
