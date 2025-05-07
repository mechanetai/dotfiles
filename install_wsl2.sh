#!/bin/bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

sh ./install_base.sh
