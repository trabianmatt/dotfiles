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
#   safe-pi / pi     — pi-coding-agent. `pi` is aliased to `safe-pi`
#                       so it always runs sandboxed by default
#                       (unlike claude/codex, which have an opt-in
#                       safe- prefix).
#   safe-omp / omp   — oh-my-pi. Same default-sandboxed alias pattern
#                       as pi.
#
# The wrappers grant: workdir rw (default), clipboard (pbcopy/pbpaste),
# plus whatever custom grants live in the personal overrides profile.
# `--trust-workdir-config` lets a project drop a `.safehouse` file
# in its root to add project-scoped grants without touching this file.
#
# Split: integration-specific secrets live in local-overrides.sb (Slack
# token, OAuth dirs, Readwise key). Infrastructure grants (PATH env,
# read/exec on tool install dirs) live here as flags. --add-dirs-ro
# auto-generates the ancestor-literal grants safehouse expects; doing
# the same in .sb requires hand-rolling those rules.
# =====================================================================

export SAFEHOUSE_APPEND_PROFILE="$HOME/dev/safehouse/local-overrides.sb"

safe() {
  safehouse \
    --append-profile="$SAFEHOUSE_APPEND_PROFILE" \
    --enable=clipboard \
    --trust-workdir-config \
    --env-pass=PATH \
    --add-dirs-ro="$HOME/.local/bin:$HOME/.local/share/uv/tools/trabian-google" \
    "$@"
}

safe-claude() { safe claude --dangerously-skip-permissions "$@" }
safe-codex()  { safe codex "$@" }
safe-pi()     { safe pi "$@" }
safe-omp()    { safe omp "$@" }

# pi and omp default to sandboxed execution. Aliases expand only
# in interactive shells / sourced rc files — scripts that invoke
# `pi` / `omp` directly bypass this, which is the desired behavior
# (script authors opt in to the safe- prefix explicitly when they
# need it).
alias pi=safe-pi
alias omp=safe-omp
