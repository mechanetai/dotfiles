#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ZSH_D_DIR="${ZDOTDIR}/zsh.d"
ZSHRC="${ZDOTDIR}/.zshrc"
SOURCE_ZSH_D_DIR="${SCRIPT_DIR}/.config/zsh/zsh.d"
GIT_DIR="${XDG_CONFIG_HOME}/git"
SOURCE_GIT_DIR="${SCRIPT_DIR}/.config/git/config.local"
SOURCE_GIT_CONFIG="${SCRIPT_DIR}/.config/git/config"
GIT_LOCAL_CONFIG="${GIT_DIR}/config.local"
GIT_CONFIG="${GIT_DIR}/config"

ensure_dir() {
  local dir_path="$1"

  if [ ! -d "${dir_path}" ]; then
    mkdir -p "${dir_path}"
    echo "作成しました: ${dir_path}"
  else
    echo "既に存在します: ${dir_path}"
  fi
}

ensure_file() {
  local file_path="$1"
  local parent_dir
  parent_dir="$(dirname -- "${file_path}")"

  if [ ! -d "${parent_dir}" ]; then
    mkdir -p "${parent_dir}"
    echo "作成しました: ${parent_dir}"
  fi

  if [ ! -f "${file_path}" ]; then
    touch "${file_path}"
    echo "作成しました: ${file_path}"
  else
    echo "既に存在します: ${file_path}"
  fi
}

ensure_dir "${ZSH_D_DIR}"
ensure_dir "${GIT_DIR}"

if [ -f "${SOURCE_GIT_CONFIG}" ]; then
  ln -sfn "${SOURCE_GIT_CONFIG}" "${GIT_CONFIG}"
  echo "リンクしました: ${GIT_CONFIG}"
else
  echo "対象ファイルがありません: ${SOURCE_GIT_CONFIG}"
fi

ensure_file "${SOURCE_GIT_DIR}"

ln -sfn "${SOURCE_GIT_DIR}" "${GIT_LOCAL_CONFIG}"
echo "リンクしました: ${GIT_LOCAL_CONFIG}"

ensure_file "${ZSHRC}"

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
