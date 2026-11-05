# Limen Homebrew tap: instructions for coding agents

Homebrew tap for [Limen](https://github.com/limen-dev/limen), installed with `brew install limen-dev/tap/limen`. The formula is generated from a Limen release; this file holds only what is specific to agents.

## Layout
- `templates/limen.rb.in`: the formula, with placeholders for the version and the four archives' SHA-256 checksums.
- `scripts/render-formula.sh <tag> <SHA256SUMS>`: fills the template into `Formula/limen.rb`.
- `.github/workflows/update-formula.yml`: runs the script for a release and opens a PR. `ci.yml` checks the scripts and the formula.

## Rules
- **Never edit `Formula/limen.rb` by hand.** Change the template or the script, then regenerate it for the current release.
- **Don't hand-write checksums.** They come from the release's `SHA256SUMS`.
- **Verify before claiming.** Run it, and say what you ran and what you didn't. A formula that has not been through `brew audit`, install and `brew test` is `unverified`.
- **Ask before irreversible or outward-facing actions:** force-push, deleting branches, merging, marking a PR ready, running a workflow that opens a PR, commenting. Look at the target before deleting or overwriting.

## Checks
- `shellcheck scripts/*.sh` after touching a script.
- `brew style Formula/limen.rb`, and with the checkout linked as the tap: `brew audit --strict --online limen-dev/tap/limen`, `brew install limen-dev/tap/limen`, `brew test limen-dev/tap/limen`.
- PRs opened by `update-formula` with the default token start no workflows: run `gh workflow run ci.yml --ref <branch>` on them.

## Git and PRs
- Conventional, small, focused commits, signed (`main` requires verified signatures). Stage specific files, never `git add -A`. Don't push or tag unless asked.
- Open PRs as drafts: `gh pr create --draft --body-file <file>`, body from `.github/pull_request_template.md` (it is not auto-filled).
