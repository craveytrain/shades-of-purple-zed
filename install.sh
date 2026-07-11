#!/usr/bin/env bash
# Installs the Shades of Purple (Cravey) Zed theme by symlinking it into
# Zed's user themes directory.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/themes/shades-of-purple.json"
DEST_DIR="$HOME/.config/zed/themes"
DEST="$DEST_DIR/shades-of-purple.json"

mkdir -p "$DEST_DIR"

if [ -L "$DEST" ] || [ -e "$DEST" ]; then
  rm -f "$DEST"
fi

ln -s "$SRC" "$DEST"

echo "Installed: $DEST -> $SRC"
echo "Restart Zed (or run 'zed: reload extensions' / 'theme selector: toggle') to pick up the theme."
