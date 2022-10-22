# Rui's dotfiles

Uses `rcm` to manage dotfiles.

## Sync from git
1. Pull
2. `make setup-dotfiles`

## Keep things in sync
1. Copy new files to config or root dir
2. Review Makefile's `IGNORE_FOLDERS`
3. Run `make dry-run` and verify symlinks are ok
4. Run `make setup-dotfiles`
5. `make to-brewfile`
6. Commit and push
