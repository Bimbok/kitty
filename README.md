# 🐱 Kitty Terminal Configuration

A polished, high-performance terminal setup featuring the **Gruvbox Dark Hard** theme, optimized for productivity and aesthetics.

## 📸 Preview

![Terminal Screenshot](Sample/Screenshot%20From%202026-04-26%2011-24-50.png)

## ✨ Key Features

- **Theme:** [Gruvbox Dark Hard](https://github.com/gruvbox-community/gruvbox) for a comfortable, high-contrast coding experience.
- **Typography:** Uses `FiraCode Nerd Font` with full ligature support.
- **Aesthetics:** 
  - 70% Background opacity with heavy blur (32px).
  - Custom background image support with tinting.
  - Powerline-style tab bar with custom activity icons.
- **Performance:** Optimized for Wayland with `sync_to_monitor` enabled.
- **UX Enhancements:**
  - Active cursor trails for better visibility.
  - Clickable curly URLs.
  - Generous 10,000 line scrollback buffer.
  - Custom padding and margins for a clean look.

## 🛠 Requirements

To get the most out of this config, you'll need:
- [Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator.
- [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) (installed as `FiraCode Nerd Font SemBd`).
- [Zsh](https://www.zsh.org/) (configured as the default shell).

## 🚀 Installation

1. Clone this repository into your kitty config directory:
   ```bash
   git clone <repo-url> ~/.config/kitty
   ```
2. (Optional) Update the `background_image` path in `kitty.conf` to point to your preferred wallpaper.
3. Reload Kitty or press `Ctrl+Shift+F5`.

## ⌨️ Useful Shortcuts

- `Ctrl + Shift + F5`: Reload configuration.
- `Ctrl + Shift + + / -`: Zoom in/out.
- `Ctrl + Shift + Backspace`: Reset font size.
