# My NixOS Configuration

I was just trying it out, I swear. Now it's my daily driver.

## The Armory

There are only a few weapons I need for war.

### Shell

[zsh](https://www.zsh.org/)

I just like it better than Bash.

### Editor

[neovim](https://neovim.io/)

I keep it pretty simple, but I do have some plugins. Less plugins now with 0.12 release, since LSP is more native.

- [catppuccin.nvim](https://github.com/catppuccin/nvim) Mocha with black background. This goes for the whole desktop.
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

### Wayland Compositor

[river-classic](https://codeberg.org/river/river-classic)

I like the simplicity and minimalism, but I intend on using the 0.4.x non-monolithic version in the future, once I learn a little Zig and author my own window manager that implements the [river-window-management-v1](https://isaacfreund.com/docs/wayland/river-window-management-v1) protocol.

### Terminal

[foot](https://codeberg.org/dnkl/foot)

Fast, lightweight, and just enough features to get the job done. I run it in server mode, which has some quirks, but it's never been a problem for me. The benefits outweigh the negatives. Fast startup time and smaller memory footprint. I use [tmux](https://github.com/tmux/tmux/wiki) anyway.

### Launcher

[fuzzel](https://codeberg.org/dnkl/fuzzel)

Just fuzzy-find and launch. Nothing else.

### Browser

[zen](https://zen-browser.app/)

Firefox, but better.

### File Manager

[nnn](https://github.com/jarun/nnn)

For anything beyond `ls`, `rm`, `cp`, and `mv`.

