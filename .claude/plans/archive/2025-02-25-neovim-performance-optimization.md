# Neovim Performance Optimization Plan

**Status: COMPLETE** — 2025-02-25
**Commits:** `182c770`, `17e3ec8`

---

## Results

| Metric | Before | After |
|--------|--------|-------|
| Startup time | ~104ms | ~59–73ms |
| Startup log lines | 343 | 123 |
| Improvement | — | ~40–45ms (~45%) |

---

## What the Diagnostics Revealed (vs. Original Audit)

The original audit was code-review-based. Running `nvim --startuptime` exposed a different picture:

**The plan was wrong about the primary bottleneck.** The audit identified supermaven (~1.5ms) as a high-priority fix, but the actual #1 culprit was `obsidian.nvim` with `lazy = false` — dragging telescope, plenary, and its entire dep chain at startup for **20–28ms self-time**. The audit never flagged it.

**Red Team findings that proved correct:**
- Supermaven fix (add `event = "InsertEnter"`) was redundant — LazyVim's extra already sets this. The custom spec was actually *overriding* the deferral.
- `ft = "ghostty"` would have broken tree-sitter-ghostty — it self-registers its filetype via `plugin/ftdetect` and was already loading correctly.
- `scrolloff = 999` was intentional behavior — changed anyway per Ed's direction.
- Removing extras from `lazyvim.json` alone doesn't remove LSPs — Mason packages need separate uninstall.

---

## Changes Made

### Commit 1 — `perf: defer obsidian, fix supermaven/flash config bugs`

| File | Change | Gain |
|------|--------|------|
| `lua/plugins/editor/obsidian.lua` | `lazy = false` → `event = "VeryLazy"` | ~25ms |
| `lua/plugins/ai/supermaven.lua` | **Deleted** — LazyVim extra handles everything; custom spec overrode InsertEnter deferral | ~18ms |
| `lua/plugins/editor/flash.lua` | Moved `modes` key inside `opts` (was silently ignored at top level) | behavior fix |

### Commit 2 — `perf: remove unused extras, defer themes, clean options`

| File | Change |
|------|--------|
| `lazyvim.json` | Removed `lang.angular`, `lang.elixir`, `lang.helm`, `lang.terraform` |
| Mason | Deleted packages: `angular-language-server`, `elixir-ls`, `helm-ls`, `terraform-ls` |
| `lua/plugins/ui/colorscheme.lua` | `lazy = true` for aura, rose-pine, tokyonight (eldritch unchanged) |
| `lua/config/options.lua` | Removed `cursorcolumn`, changed `scrolloff = 999` → `8` |
| `lua/plugins/languages/markdown.lua` | Added `ft = "markdown"` to mdx.nvim and bullets.vim |
| `lua/plugins/languages/python.lua` | Removed dead `ruff_lsp` block (was already disabled by enabled loop) |

---

## What Was Skipped and Why

| Item | Reason |
|------|--------|
| `ft = "ghostty"` for tree-sitter-ghostty | Plugin self-registers filetype via `plugin/` dir — adding ft trigger creates circular dep, plugin would never load |
| Go LSP hints reduction | Not measurably impacting startup; subjective tradeoff, deferred |
| Formatter dedup (biome/prettier) | Not a startup issue |
| TreeSitter parser trimming | Low impact, risk of breaking language support |

---

## Lessons for Future Optimization

1. **Run diagnostics first.** Code audits miss runtime load order. `nvim --startuptime` is ground truth.
2. **Check LazyVim extras before modifying plugin specs.** LazyVim may already configure a plugin correctly — adding a parallel spec can override the extra's behavior.
3. **`defaults.lazy = false` makes the whole custom layer eager.** Any plugin without an explicit trigger loads at startup. This is the LazyVim default and a constant source of hidden eager loads.
4. **Mason state is separate from lazyvim.json.** Removing an extra does not uninstall its LSP servers — must `rm -rf ~/.local/share/nvim/mason/packages/<name>` manually.
5. **Plugins with `plugin/` directories self-load.** Don't add `ft` or `event` triggers to these — they have their own load mechanism.
6. **`init` runs at startup even for `lazy = true` plugins.** Only `config` and `opts` are deferred.
