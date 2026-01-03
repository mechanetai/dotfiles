typeset -A abbreviations=(
  'a' 'aws'
  'aws l' 'aws login'

  'e' 'echo'

  'g' 'git'
  'git sw' 'git switch'
  'git switch c' 'git switch -c'

  'd' 'docker'
  'docker c' 'docker compose'
  'docker compose u' 'docker compose up'

  'za' 'echo $HOME/.config/zsh/zsh.d/abbr.zsh'
  'co' '| xargs code'
  'so' '>/dev/null; source $_'
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
