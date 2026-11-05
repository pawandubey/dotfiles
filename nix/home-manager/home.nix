{ config, pkgs, nixgl, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "pawan";
  home.homeDirectory = "/home/pawan";
  home.stateVersion = "24.11";

  targets.genericLinux.enable = true;

  # targets.genericLinux.nixGL = {
  #   packages = nixgl.packages;
  #   defaultWrapper = "mesa";
  #   installScripts = [
  #     "mesa"
  #   ];
  # };

  home.packages = with pkgs; [
    pass
    wl-clipboard
    emacs-pgtk
    # source-code-pro
    nerd-fonts.sauce-code-pro
    jost
    rustup
    uv
    iperf3
    makemkv
    powertop
    # (pkgs.vlc.override { libbluray = pkgs.libbluray.override { withAACS = true; withBDplus = true; }; })
    handbrake
    mise
    sipcalc
    skim
    sqlite
    nodejs_latest
    ripgrep
    gh
  ];
  programs.home-manager.enable = true;

  programs.vscode = {
    enable = false; # https://github.com/NixOS/nixpkgs/issues/89599
    # extensions = with pkgs.vscode-extensions; [
    #   ms-vsliveshare.vsliveshare
    #   golang.go
    #   shopify.ruby-lsp
    # ];
  };

  fonts.fontconfig.enable = true; # needed to refresh fc-cache after installing font packages like source-code-pro

  # For now, Wezterm is broken: https://github.com/NixOS/nixpkgs/issues/336069
  # programs.wezterm = {
  #   enable = false; # issues with resizing on tab and mesa compatability, install via flatpak
  #   package = config.lib.nixGL.wrap pkgs.wezterm;
  # };

  home.file = {
    ".wezterm.lua" = {
      enable = false; # https://github.com/NixOS/nixpkgs/issues/336069
      text = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This will hold the configuration.
        local config = wezterm.config_builder()

        -- This is where you actually apply your config choices

        -- For example, changing the color scheme:
        -- config.color_scheme = 'AdventureTime'
        config.color_scheme = 'Monokai (dark) (terminal.sexy)'
        config.window_background_opacity = 0.5
        config.text_background_opacity = 0.3
        config.initial_rows = 80
        config.initial_cols = 120

        -- bug with default nix install
        config.front_end = "WebGpu"


        -- font fixes
        -- config.freetype_load_flags = 'NO_HINTING'
        -- config.freetype_load_target = 'Light'
        config.dpi = 153

        -- and finally, return the configuration to wezterm
        return config
      '';
    };

    ".bashrc" = {
      enable = true;
      source = ../../bash/.bashrc;
    };

    ".bash_profile" = {
      enable = true;
      source = ../../bash/.bash_profile;
    };

    ".profile" = {
      enable = true;
      source = ../../bash/.profile;
    };

    ".bash_functions" = {
      enable = true;
      source = ../../bash/.bash_functions;
    };

    "git-completion.bash" = {
      source = ../../git/git-completion.bash;
    };

    ".git-prompt.sh" = {
      source = ../../git/.git-prompt.sh;
    };

    ".emacs.d" = {
      source = pkgs.fetchFromGitHub {
        owner = "syl20bnr";
        repo = "spacemacs";
        rev = "cc8ff4c0c26e577b48b94c4440a85eb4af3cdf38";
        hash = "sha256-fooohHaRYKPTO664Eipl8L3phImjw98JJ4eDEXA3jUo="; # replace with pkgs.lib.fakeHash to output expected hash;
      };
      recursive = true;
      force = true;
    };

    ".spacemacs" = {
      source = ../../emacs/.spacemacs;
    };
  };
}
