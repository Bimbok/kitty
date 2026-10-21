#!/usr/bin/env bash
# Fuzzy-select a saved Kitty session file and load it in the current Kitty OS window.
set -euo pipefail

for cmd in fzf kitty; do
  command -v "$cmd" >/dev/null 2>&1 || {
    printf 'kitty-session-picker: required command not found: %s\n' "$cmd" >&2
    exit 1
  }
done

# Kitty's overlay inherits KITTY_LISTEN_ON when remote control is enabled.
target="${KITTY_LISTEN_ON:-unix:/tmp/kitty-${USER}}"

# Override with a colon-separated list if you keep session files elsewhere.
# Supports both *.kitty-session and extensionless session files (e.g. Tide-Island).
session_dirs="${KITTY_SESSION_DIRS:-$HOME/.config/kitty/sessions:$HOME/.config/kitty}"

# Use NUL separators so paths containing spaces are handled safely.
mapfile -d '' session_files < <(
  IFS=:
  for dir in $session_dirs; do
    [[ -d "$dir" ]] || continue
    find "$dir" -maxdepth 1 -type f \( -name '*.kitty-session' -o ! -name '*.*' \) ! -name 'kitty.conf' ! -name 'kitty-session-picker.sh' -print0
  done | sort -z
)

if ((${#session_files[@]} == 0)); then
  printf 'No saved Kitty session files found in:\n%s\n' "${session_dirs//:/\n}" >&2
  exit 0
fi

# Build display rows: full session-file path, tab, friendly name, tab, first cd path if present.
rows="$(for file in "${session_files[@]}"; do
  name="$(basename "$file")"
  name="${name%.kitty-session}"
  cwd="$(sed -nE 's/^[[:space:]]*cd[[:space:]]+//p' "$file" | head -n1 | sed -E 's/^"(.*)"$/\1/')"
  [[ -n "$cwd" ]] || cwd='(session-defined working directory)'
  printf '%s\t%s\t%s\n' "$file" "$name" "$cwd"
done)"

selection="$(printf '%s\n' "$rows" | fzf \
  --delimiter=$'\t' \
  --with-nth=2,3 \
  --nth=2,3 \
  --prompt='Kitty saved sessions > ' \
  --header='Type to filter · Enter to load in this Kitty window · Esc to cancel' \
  --height=100% --layout=reverse --border --no-multi \
  --preview='sed -n "1,100p" {1}' \
  --preview-window='right,45%,wrap')" || exit 0

[[ -n "$selection" ]] || exit 0
session_file="${selection%%$'\t'*}"

# Loading a session file through goto_session switches the current Kitty OS window;
# it does not spawn a new Kitty application window.
kitty @ --to "$target" action goto_session "$session_file"

kitty @ --to "$target" close-tab
