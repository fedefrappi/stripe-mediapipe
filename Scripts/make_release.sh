#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="$(tr -d '[:space:]' < "$ROOT/VERSION")"
MEDIAPIPE_VERSION="$(tr -d '[:space:]' < "$ROOT/MEDIAPIPE_VERSION")"

ARTIFACTS="$ROOT/Artifacts"
DIST="$ROOT/Dist"

[ -d "$ARTIFACTS" ] || { echo "No Artifacts/. Run Scripts/refresh_artifacts.sh first." >&2; exit 1; }

missing=0
while IFS= read -r framework; do
  [ -f "$framework/Info.plist" ] || { echo "error: $framework has no Info.plist" >&2; missing=1; }
done < <(find "$ARTIFACTS" -type d -name "*.framework")
[ "$missing" -eq 0 ] || { echo "Run Scripts/refresh_artifacts.sh to rebuild the artifacts." >&2; exit 1; }

rm -rf "$DIST" && mkdir -p "$DIST"

for name in MediaPipeTasksVision MediaPipeCommonGraphLibraries MediaPipeTasksCommon; do
  ( cd "$ARTIFACTS" && zip -qry "$DIST/$name.xcframework.zip" "$name.xcframework" )
  sum="$(swift package compute-checksum "$DIST/$name.xcframework.zip")"
  echo "$name  $sum"
  python3 - "$ROOT/Package.swift" "$name" "$sum" <<'PY'
import re, sys
path, name, checksum = sys.argv[1:4]
s = open(path).read()
pattern = r'(name: "%s",\n            url: "[^"]*",\n            checksum: ")[0-9a-f]{64}(")' % name
s, n = re.subn(pattern, r'\g<1>%s\g<2>' % checksum, s)
if n != 1:
    sys.exit("could not write the checksum for %s" % name)
open(path, "w").write(s)
PY
done

( cd "$ROOT" && zip -qry "$DIST/StripeMediaPipe-$VERSION.zip" Artifacts Sources LICENSE-MediaPipe )

sed -i '' "s|^let version = \".*\"|let version = \"$VERSION\"|" "$ROOT/Package.swift"
sed -i '' "s|^  s.version                  = '.*'|  s.version                  = '$VERSION'|" "$ROOT/StripeMediaPipe.podspec"

echo
echo "Assets are in Dist/. Commit Package.swift, then run:"
echo "  git tag $VERSION && git push origin $VERSION"
echo "  gh release create $VERSION Dist/* --title $VERSION --notes \"MediaPipeTasksVision $MEDIAPIPE_VERSION\""
echo "  pod trunk push StripeMediaPipe.podspec"
