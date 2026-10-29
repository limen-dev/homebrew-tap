# limen-dev/homebrew-tap

Homebrew formulae for [Limen](https://github.com/limen-dev/limen).

```sh
brew install limen-dev/tap/limen
```

It installs the `limen` CLI and `limen-audit-verify` (macOS and Linux, Apple Silicon/arm64 and Intel/x86_64), with shell completions. The server binaries are in the same release archives but aren't installed; run those from the container images.

## Updating the formula

There is no formula until the first Limen release. `Formula/limen.rb` is generated, so don't edit it by hand:

- `templates/limen.rb.in` is the formula, with placeholders for the version and the four archives' SHA-256 checksums.
- `scripts/render-formula.sh <tag> <SHA256SUMS>` fills them in from the release's `SHA256SUMS` file.
- The `update-formula` workflow does both for a release and opens a pull request:

  ```sh
  gh workflow run update-formula.yml -R limen-dev/homebrew-tap -f tag=v0.1.0
  ```

While `limen-dev/limen` is private, the workflow needs a `LIMEN_RELEASES_TOKEN` secret that can read its releases, and installing needs a token too, so the tap is only useful once Limen is public. Later, Limen's release workflow can start this workflow by itself.
