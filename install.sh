#!/usr/bin/env bash
# Install Uthman's Pi skills: curl -fsSL https://raw.githubusercontent.com/codetesla51/skills/main/install.sh | bash
set -e
DST="${PI_SKILLS_DIR:-$HOME/.pi/agent/pi-hermes-memory/skills}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
git clone -q --depth 1 https://github.com/codetesla51/skills.git "$TMP/skills"
mkdir -p "$DST"
rm -f "$DST/README.md" "$DST/install.sh" "$DST/.gitignore"
cp -r "$TMP/skills/." "$DST/"
rm -rf "$DST/.git" "$DST/README.md" "$DST/install.sh" "$DST/LICENSE"
echo "installed $(ls -d "$DST"/*/ | wc -l) skills -> $DST"
