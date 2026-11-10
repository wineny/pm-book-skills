#!/usr/bin/env bash
# pm-book-skills 설치: mom-test, continuous-discovery 스킬을 Codex·Claude Code 스킬 폴더에 복사한다.
# 사용: curl -fsSL https://raw.githubusercontent.com/wineny/pm-book-skills/main/install.sh | bash
set -euo pipefail

REPO="https://github.com/wineny/pm-book-skills.git"
SKILLS="mom-test continuous-discovery"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# 레포 안에서 실행했으면 그 파일을 쓰고, 아니면 내려받는다.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -n "$SRC_DIR" ] && [ -d "$SRC_DIR/skills/mom-test" ]; then
  SRC="$SRC_DIR/skills"
else
  git clone --depth 1 --quiet "$REPO" "$TMP/repo"
  SRC="$TMP/repo/skills"
fi

install_to() {
  local dest="$1"
  mkdir -p "$dest"
  for s in $SKILLS; do
    rm -rf "${dest:?}/$s"
    cp -R "$SRC/$s" "$dest/$s"
  done
  echo "설치함: $dest ($SKILLS)"
}

# Codex 는 항상 설치한다.
install_to "${CODEX_HOME:-$HOME/.codex}/skills"

# Claude Code 를 쓰고 있으면 거기에도 설치한다.
if [ -d "$HOME/.claude" ]; then
  install_to "$HOME/.claude/skills"
fi

echo
echo "끝. Codex 를 새로 열고 이렇게 불러 보세요:"
echo "  mom-test 스킬로 이 인터뷰 질문지 점검해 줘."
echo "  continuous-discovery 스킬로 기회 솔루션 트리 만들자. 목표는 ___ 야."
