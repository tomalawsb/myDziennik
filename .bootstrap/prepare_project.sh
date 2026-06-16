#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$RUNNER_TEMP/DzienniczekSzpontniczek"
OVERLAY_ZIP="$RUNNER_TEMP/myDziennik-overlay.zip"

git clone --depth 1 https://github.com/szponciciel04/DzienniczekSzpontniczek.git "$BASE_DIR"
rm -rf "$BASE_DIR/.git"

rsync -a --delete \
  --exclude='.git/' \
  --exclude='.bootstrap/' \
  --exclude='.github/workflows/bootstrap.yml' \
  "$BASE_DIR/" ./

cat .bootstrap/overlay_00 .bootstrap/overlay_01 .bootstrap/overlay_02 .bootstrap/overlay_03 \
  | tr -d '\r\n' \
  | base64 --decode > "$OVERLAY_ZIP"

unzip -t "$OVERLAY_ZIP"
unzip -o "$OVERLAY_ZIP" -d .

rm -rf iosApp composeApp/src/iosMain artwork
rm -rf composeApp/src/androidMain/res/mipmap-*
rm -rf composeApp/src/androidMain/res/drawable-v24
rm -f composeApp/src/androidMain/ic_launcher-playstore.png
rm -f .github/workflows/build.yml
rm -rf .bootstrap
rm -f .github/workflows/bootstrap.yml
chmod +x gradlew

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add -A
git commit -m "Kompletna aplikacja myDziennik 1.0"
git push origin HEAD:main
