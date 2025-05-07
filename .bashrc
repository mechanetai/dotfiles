#!/bin/bash

# XDG Base Directory
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

# shellcheck disable=SC1091
source "${XDG_CONFIG_HOME}"/python/pythonstartup.sh

# mv .bash_history
export HISTFILE="${XDG_STATE_HOME}"/bash/history
