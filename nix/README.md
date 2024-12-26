# nixpkgs and home-manager configs

Mostly based on https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/

## Pre-Setup

- Install nixpkgs with multi-user support
- Enable nix-command and flakes experimental features (not necessary if Determinate Systems installer is used)
- Clone this repo

## Setup

- Inside of this repo, run `nix run nixpkgs#home-manager -- switch --flake nix/#pawan`
- Afterwards run `home-manager switch --flake nix/#pawan` (replace `nix/` with the relative path to the folder containing the `flake.nix` file if necessary.

## Notes and gotchas

- I want to use wezterm but at this point it is borked. https://github.com/NixOS/nixpkgs/issues/336069
- It is not necessary to use this to setup the dotfiles, `gnu stow` will also do the trick
- Nix will ignore any files not added to git, so if a new file is created it will need to be added to the staging area for it to be picked up
- Symlinking with home.file creates the symlinks in the nix store by default, which makes it slightly inconvenient to modify configs as it requires a home-manager switch every time. It can be remediated with `mkOutOfStoreSymlink` to create direct symlinks. Maybe something to consider if it becomes too annoying to deal with.
- nixGL is required to wrap any desktop apps. Use the example from wezterm that uses `config.lib.nixGL.wrap`

