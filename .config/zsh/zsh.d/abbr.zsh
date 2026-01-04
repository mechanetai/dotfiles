typeset -A base=(
  a aws
  "aws l" "aws login"

  g git
  "git sw" "git switch"
  "git switch c" "git switch -c"
  "git f" "git fetch"
  "git a" "git add -A"
  "git c" "git commit -m ''"

  d docker
  "docker c" "docker compose"
  "docker compose u" "docker compose up"
  "docker compose up d" "docker compose up -d"

  za 'echo $HOME/.config/zsh/zsh.d/abbr.zsh'
)

typeset -A phrase=(
  "${base[za]} co" "${base[za]} | xargs code"
  "${base[za]} so" "${base[za]} >/dev/null; source \$_"
)

typeset -A abbreviations=(
  ${(kv)base}
  ${(kv)phrase}
)

magic-abbrev-expand() {
  local lb=$LBUFFER

  if [[ -n $lb ]] && (( ${+abbreviations[$lb]} )); then
    LBUFFER=${abbreviations[$lb]}
  fi

  zle self-insert
}

zle -N magic-abbrev-expand
bindkey " " magic-abbrev-expand
