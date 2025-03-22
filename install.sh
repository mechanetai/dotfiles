#!/bin/bash

# Install Nix
bash <(curl -L https://nixos.org/nix/install) --no-daemon
. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Link home.nix
mkdir -p ~/.config/home-manager
ln -s "./.config/home-manager/home.nix" "$HOME/.config/home-manager/"

# Install Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch
cd "$HOME" || exit
