# =====================================================================
# Agent Safehouse wrappers
#
# Sandbox grants repo: https://github.com/trabianmatt/safehouse (private)
# Binary:              safehouse (installed via Homebrew)
# Upstream docs:       https://agent-safehouse.dev/docs/
#
# Usage:
#   safe <cmd>       — run any command inside the sandbox
#   safe-claude      — Claude Code (permission prompts disabled;
#                       sandbox is the real security layer)
#   safe-codex       — Codex CLI
#
# The wrappers grant: workdir rw (default), clipboard (pbcopy/pbpaste),
# plus whatever custom grants live in the personal overrides profile.
# `--trust-workdir-config` lets a project drop a `.safehouse` file
# in its root to add project-scoped grants without touching this file.
# =====================================================================

export SAFEHOUSE_APPEND_PROFILE="$HOME/dev/safehouse/local-overrides.sb"

safe() {
  safehouse \
    --append-profile="$SAFEHOUSE_APPEND_PROFILE" \
    --enable=clipboard \
    --trust-workdir-config \
    "$@"
}

safe-claude() { safe claude --dangerously-skip-permissions "$@" }
safe-codex()  { safe codex "$@" }
