#!/bin/bash

# 環境変数や設定をシェルに読み込ませる
bash "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Link home.nix
mkdir --parents ~/.config/home-manager
target="$HOME/.config/home-manager/home.nix"
source="$(pwd)/.config/home-manager/home.nix"

# シンボリックリンクがすでに正しく張られているなら何もしない
if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
  echo "Symlink already correctly exists: $target -> $source"
else
  ln -sf "$source" "$target"
  echo "Symlink created or updated: $target -> $source"
fi

# Install Home Manager
NIX_VERSION=25.05
nix-channel --add "https://nixos.org/channels/nixos-${NIX_VERSION}" nixpkgs
nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${NIX_VERSION}.tar.gz" home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# activate Home Manager
# home-manager switch
# cd "$HOME" || exit
