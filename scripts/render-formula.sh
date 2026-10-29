#!/usr/bin/env bash
# Writes Formula/limen.rb for one Limen release from the release's SHA256SUMS.
#
#   scripts/render-formula.sh v0.1.0 path/to/SHA256SUMS
set -euo pipefail

tag="${1:?usage: $0 <tag> <SHA256SUMS>}"
sums="${2:?usage: $0 <tag> <SHA256SUMS>}"
[[ "$tag" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]] || { echo "not a release tag: $tag" >&2; exit 1; }
version="${tag#v}"
here="$(cd "$(dirname "$0")/.." && pwd)"

args=(-e "s/@VERSION@/${version}/g")
for target in aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-gnu x86_64-unknown-linux-gnu; do
  file="limen-${tag}-${target}.tar.gz"
  sha="$(awk -v f="$file" '$2 == f || $2 == "*" f { print $1 }' "$sums")"
  [[ "$sha" =~ ^[0-9a-f]{64}$ ]] || { echo "no SHA-256 for $file in $sums" >&2; exit 1; }
  args+=(-e "s/@SHA_${target}@/${sha}/g")
done

mkdir -p "$here/Formula"
sed "${args[@]}" "$here/templates/limen.rb.in" > "$here/Formula/limen.rb"
! grep -n '@[A-Za-z_0-9-]*@' "$here/Formula/limen.rb" || { echo "unfilled placeholder" >&2; exit 1; }
echo "wrote Formula/limen.rb for ${tag}"
