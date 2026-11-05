# limen-dev/homebrew-tap

Homebrew formulae for [Limen](https://github.com/limen-dev/limen).

```sh
brew install limen-dev/tap/limen
```

It installs the `limen` CLI and `limen-audit-verify` (macOS and Linux, Apple Silicon/arm64 and Intel/x86_64), with shell completions. The server binaries are in the same release archives but aren't installed; run those from the container images.

## Updating the formula

`Formula/limen.rb` is generated, so don't edit it by hand:

- `templates/limen.rb.in` is the formula, with placeholders for the version and the four archives' SHA-256 checksums.
- `scripts/render-formula.sh <tag> <SHA256SUMS>` fills them in from the release's `SHA256SUMS` file.
- The `update-formula` workflow does both and opens a pull request. It runs every hour and follows the latest Limen release, pre-releases included, and starts `ci.yml` on the new branch. To do a specific release now:

  ```sh
  gh workflow run update-formula.yml -R limen-dev/homebrew-tap -f tag=v0.1.0
  ```

Merge the pull request once `ci` is green. It needs no secret, because Limen's releases are public.
