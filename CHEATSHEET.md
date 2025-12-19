# NOE.ED Quick Reference Cheatsheet

### Mode Exit

```
jk              Exit INSERT mode
<Esc>           Exit terminal / clear cursors
```

### Navigation

```
gh              Start of line (^)
gl              End of line ($)
<C-h/j/k/l>     Navigate splits
<leader>jj      Flash jump
```

### Line Operations

```
<A-j> / <A-down>     Move line down
<A-k> / <A-up>       Move line up
<A-C-down>           Duplicate line down
<A-C-up>             Duplicate line up
```

### Editing

```
U                    Redo
<Enter>              Toggle fold
> / <                Indent right/left
<C-]> / <C-[>        Indent right/left
```

### Multi-Cursor

```
<C-S-l>              Add cursor to ALL matches
<C-A-down>           Add cursor at next match
<C-A-up>             Add cursor at prev match
<C-down>             Skip next match
<C-up>               Skip prev match
<C-leftmouse>        Add/remove cursor
<C-q>                Toggle cursor
<left>/<right>       Select different cursor
<leader>x            Delete current cursor
<Esc>                Clear all cursors
```

### Files

```
<leader>fs           Save file
<leader>fS           Save without formatting
<leader>ff           Find file
<leader>fg           Live grep
```

### Windows/Splits

```
<C-h/j/k/l>          Navigate splits
<leader>wh/j/k/l     Navigate splits (alt)
```

### Terminal

```
<C-`>                Toggle terminal
<Esc>                Exit terminal mode
```

### Git

```
<leader>gg           Lazygit (borderless)
```

### AI

```
<C-A-S-c>            Toggle Claude Code
```

### LSP

```
<leader>ih           Toggle inlay hints
gd                   Go to definition
gD                   Go to source definition (TS)
gR                   File references (TS)
K                    Hover documentation
```

### TypeScript

```
<leader>co           Organize imports
<leader>cM           Add missing imports
<leader>cu           Remove unused imports
<leader>cD           Fix all diagnostics
<leader>cV           Select TS version
```

### Python

```
<leader>co           Organize imports
<leader>vs           Select venv
<leader>vc           Cached venv
<leader>dPt          Debug method
<leader>dPc          Debug class
```

### Laravel

```
<leader>LL           Laravel picker
<leader>La           Artisan
<leader>Lt           Actions
<leader>Lr           Routes
<leader>Lm           Make
<leader>Lc           Commands
<leader>Lo           Resources
<leader>Lp           Command center
<C-g>                View finder
```

### Dashboard Shortcuts

```
N    New file
r    Recent files
f    Find file
g    Find text
o    Sessions
d    Dotfiles
v    NOE.ED config
n    FieldNotes
x    Lazy Extras
l    Lazy
q    Quit
```

### Plugin Management

```
:Lazy                Open Lazy.nvim
:Mason               Open Mason (LSP installer)
:LazyExtras          Toggle language packs
```
