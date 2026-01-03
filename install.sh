#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ZSH_DIR="${HOME}/.config/zsh"
ZSH_D_DIR="${ZSH_DIR}/zsh.d"
ZSHRC="${ZSH_DIR}/.zshrc"
SOURCE_ZSH_D_DIR="${SCRIPT_DIR}/.config/zsh/zsh.d"

if [ ! -d "${ZSH_DIR}" ]; then
  mkdir -p "${ZSH_DIR}"
  echo "作成しました: ${ZSH_DIR}"
else
  echo "既に存在します: ${ZSH_DIR}"
fi

if [ ! -d "${ZSH_D_DIR}" ]; then
  mkdir -p "${ZSH_D_DIR}"
  echo "作成しました: ${ZSH_D_DIR}"
else
  echo "既に存在します: ${ZSH_D_DIR}"
fi

if [ ! -f "${ZSHRC}" ]; then
  touch "${ZSHRC}"
  echo "作成しました: ${ZSHRC}"
else
  echo "既に存在します: ${ZSHRC}"
fi

ZSHRC_SNIPPET_BEGIN="# >>> zsh.d (managed by dotfiles install)"
if ! grep -Fqs "${ZSHRC_SNIPPET_BEGIN}" "${ZSHRC}"; then
  cat <<'EOF' >> "${ZSHRC}"
# >>> zsh.d (managed by dotfiles install)
# zsh.d配下の設定を読み込みます。
for f in "$ZDOTDIR"/zsh.d/*.zsh(N); do
  source "$f"
done
# <<< zsh.d
EOF
  echo "追記しました: ${ZSHRC}"
else
  echo "既に追記済みです: ${ZSHRC}"
fi

if [ -d "${SOURCE_ZSH_D_DIR}" ]; then
  for src_path in "${SOURCE_ZSH_D_DIR}"/*; do
    if [ -f "${src_path}" ]; then
      ln -sfn "${src_path}" "${ZSH_D_DIR}/$(basename -- "${src_path}")"
      echo "リンクしました: ${ZSH_D_DIR}/$(basename -- "${src_path}")"
    fi
  done
else
  echo "対象ディレクトリがありません: ${SOURCE_ZSH_D_DIR}"
fi
