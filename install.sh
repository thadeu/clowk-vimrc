#!/usr/bin/env bash
#
# clowk-vimrc — one-line installer
#
#   curl -fsSL https://raw.githubusercontent.com/thadeu/clowk-vimrc/main/install.sh | bash
#
# It copies the repo `vimrc` to ~/.vimrc, installs vim-plug and runs :PlugInstall.

set -euo pipefail

REPO="${CLOWK_VIMRC_REPO:-thadeu/clowk-vimrc}"
REF="${CLOWK_VIMRC_REF:-main}"
VIMRC_DEST="${CLOWK_VIMRC_DEST:-$HOME/.vimrc}"

PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
PLUG_DEST="$HOME/.vim/autoload/plug.vim"

INSTALL_DEPS=1
INSTALL_PLUGINS=1
DO_UNINSTALL=0
KEEP_BACKUP=1

if [ -t 1 ]; then
  C_RESET=$'\033[0m'; C_BLUE=$'\033[34m'; C_GREEN=$'\033[32m'
  C_YELLOW=$'\033[33m'; C_RED=$'\033[31m'; C_DIM=$'\033[2m'
else
  C_RESET=""; C_BLUE=""; C_GREEN=""; C_YELLOW=""; C_RED=""; C_DIM=""
fi

info() { printf '%s==>%s %s\n' "$C_BLUE" "$C_RESET" "$*"; }
ok()   { printf '%s  ok%s %s\n' "$C_GREEN" "$C_RESET" "$*"; }
warn() { printf '%s  !!%s %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
die()  { printf '%serror%s %s\n' "$C_RED" "$C_RESET" "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
clowk-vimrc installer

Usage:
  install.sh [options]

Options:
  --ref <ref>     Branch, tag or commit to install from (default: main)
  --no-deps       Do not install system packages (vim, git, curl)
  --no-plugins    Copy the vimrc only, do not run :PlugInstall
  --no-backup     Overwrite an existing ~/.vimrc without a backup copy
  --uninstall     Remove ~/.vimrc, ~/.vim/plugged and vim-plug
  -h, --help      Show this help

Environment:
  CLOWK_VIMRC_REPO   GitHub repo (default: thadeu/clowk-vimrc)
  CLOWK_VIMRC_REF    Same as --ref
  CLOWK_VIMRC_DEST   Target file (default: ~/.vimrc)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --ref)        REF="${2:-}"; [ -n "$REF" ] || die "--ref needs a value"; shift 2 ;;
    --ref=*)      REF="${1#*=}"; shift ;;
    --no-deps)    INSTALL_DEPS=0; shift ;;
    --no-plugins) INSTALL_PLUGINS=0; shift ;;
    --no-backup)  KEEP_BACKUP=0; shift ;;
    --uninstall)  DO_UNINSTALL=1; shift ;;
    -h|--help)    usage; exit 0 ;;
    *)            die "unknown option: $1 (use --help)" ;;
  esac
done

RAW_BASE="https://raw.githubusercontent.com/${REPO}/${REF}"

has() { command -v "$1" >/dev/null 2>&1; }

sudo_cmd() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif has sudo; then
    sudo -n true 2>/dev/null || warn "sudo can ask for your password"
    sudo "$@"
  else
    return 1
  fi
}

# ---------------------------------------------------------------- uninstall

if [ "$DO_UNINSTALL" -eq 1 ]; then
  info "Removing clowk-vimrc"

  if [ -f "$VIMRC_DEST" ]; then rm -f "$VIMRC_DEST"; ok "removed $VIMRC_DEST"; fi
  if [ -d "$HOME/.vim/plugged" ]; then rm -rf "$HOME/.vim/plugged"; ok "removed ~/.vim/plugged"; fi
  if [ -f "$PLUG_DEST" ]; then rm -f "$PLUG_DEST"; ok "removed vim-plug"; fi

  backups="$(ls -1 "$HOME"/.vimrc.bak.* 2>/dev/null | tr '\n' ' ' || true)"
  if [ -n "$backups" ]; then warn "backups kept: $backups"; fi

  exit 0
fi

# ---------------------------------------------------------------- packages

install_deps() {
  local missing=""

  has vim  || missing="$missing vim"
  has git  || missing="$missing git"
  has curl || missing="$missing curl"

  missing="${missing# }"

  if [ -z "$missing" ]; then
    ok "vim, git and curl are present"
    return 0
  fi

  if [ "$INSTALL_DEPS" -eq 0 ]; then
    die "missing: $missing (installed with --no-deps)"
  fi

  info "Installing: $missing"

  # shellcheck disable=SC2086
  if has apt-get; then
    sudo_cmd env DEBIAN_FRONTEND=noninteractive apt-get update -qq &&
      sudo_cmd env DEBIAN_FRONTEND=noninteractive apt-get install -y $missing
  elif has dnf; then
    sudo_cmd dnf install -y $missing
  elif has yum; then
    sudo_cmd yum install -y $missing
  elif has apk; then
    sudo_cmd apk add --no-cache $missing
  elif has pacman; then
    sudo_cmd pacman -Sy --noconfirm $missing
  elif has zypper; then
    sudo_cmd zypper install -y $missing
  elif has brew; then
    brew install $missing
  else
    die "no known package manager, install these first: $missing"
  fi || die "package install failed, install these first: $missing"

  ok "packages installed"
}

install_deps

# ---------------------------------------------------------------- vimrc

fetch_vimrc() {
  local tmp="$1" src=""

  # Local run: git clone + ./install.sh
  if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/vimrc"
  fi

  if [ -n "$src" ] && [ -f "$src" ]; then
    info "Using local vimrc: $src"
    cp "$src" "$tmp"
  else
    info "Downloading vimrc from ${REPO}@${REF}"
    curl -fsSL "${RAW_BASE}/vimrc" -o "$tmp" \
      || die "download failed: ${RAW_BASE}/vimrc"
  fi

  [ -s "$tmp" ] || die "downloaded vimrc is empty"
}

TMP_VIMRC="$(mktemp "${TMPDIR:-/tmp}/clowk-vimrc.XXXXXX")"
trap 'rm -f "$TMP_VIMRC"' EXIT

fetch_vimrc "$TMP_VIMRC"

if [ -e "$VIMRC_DEST" ] && ! cmp -s "$TMP_VIMRC" "$VIMRC_DEST"; then
  if [ "$KEEP_BACKUP" -eq 1 ]; then
    BACKUP="${VIMRC_DEST}.bak.$(date +%Y%m%d%H%M%S)"
    cp "$VIMRC_DEST" "$BACKUP"
    warn "old vimrc saved as $BACKUP"
  else
    warn "overwriting $VIMRC_DEST without a backup"
  fi
fi

install -m 0644 "$TMP_VIMRC" "$VIMRC_DEST"
ok "wrote $VIMRC_DEST"

# ---------------------------------------------------------------- vim-plug

if [ ! -f "$PLUG_DEST" ]; then
  info "Installing vim-plug"
  mkdir -p "$(dirname "$PLUG_DEST")"
  curl -fsSL "$PLUG_URL" -o "$PLUG_DEST" || die "vim-plug download failed"
  ok "vim-plug installed"
else
  ok "vim-plug already present"
fi

# ---------------------------------------------------------------- plugins

if [ "$INSTALL_PLUGINS" -eq 1 ]; then
  info "Installing plugins (:PlugInstall) — this can take some minutes"

  # </dev/null keeps vim away from the stdin of `curl ... | bash`
  if vim -es -u "$VIMRC_DEST" -i NONE \
        -c 'PlugInstall --sync' -c 'qall!' </dev/null >/dev/null 2>&1; then
    ok "plugins installed"
  else
    warn "PlugInstall returned an error, open vim and run :PlugInstall to see it"
  fi

  vim --version 2>/dev/null | head -1 || true
else
  warn "plugins skipped, run :PlugInstall inside vim"
fi

# ---------------------------------------------------------------- report

vim_major="$(vim --version 2>/dev/null | sed -n '1s/^VIM - Vi IMproved \([0-9]\{1,\}\).*/\1/p')"

missing_opt=""
has node || missing_opt="${missing_opt}  - node (coc.nvim, copilot.vim, markdown-preview)\n"
has go   || missing_opt="${missing_opt}  - go (vim-go)\n"
has rg   || missing_opt="${missing_opt}  - ripgrep (makes fuzzbox faster, obeys .gitignore)\n"
has jq   || missing_opt="${missing_opt}  - jq (JSON format maps)\n"

echo
ok "clowk-vimrc is ready"

if [ -n "$vim_major" ] && [ "$vim_major" -lt 9 ]; then
  warn "vim $vim_major found: fuzzbox needs vim 9+, so <Space><Space> uses fzf here"
fi

if [ -n "$missing_opt" ]; then
  echo "${C_DIM}Optional tools that are not installed:${C_RESET}"
  printf "${C_DIM}%b${C_RESET}" "$missing_opt"
  echo "${C_DIM}The other plugins work without them.${C_RESET}"
fi
