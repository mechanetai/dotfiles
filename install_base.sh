#!/bin/bash

# 環境変数や設定をシェルに読み込ませる
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Link home.nix
mkdir --parents ~/.config/home-manager
ln --symbolic "./.config/home-manager/home.nix" "$HOME/.config/home-manager/"

# Install Home Manager
nix-channel --add https://nixos.org/channels/nixos-24.11 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# activate Home Manager
home-manager switch
cd "$HOME" || exit
