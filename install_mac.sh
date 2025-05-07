#!/bin/bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) # Macの場合、standalone installは使えない

sh ./install_base.sh
