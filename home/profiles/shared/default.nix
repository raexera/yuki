{
  inputs,
  pkgs,
  config,
  ...
}: let
  mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
      sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
    };
  });
in {
  nixpkgs.config.allowUnfree = true;
  home = {
    packages = with pkgs; [
      # Apps
      mpv-unwrapped
      pavucontrol
      cinnamon.nemo
      imv
      neovim
      zoom-us

      # CLI Tools
      todo
      hyperfine
      fzf
      glxinfo
      ghq
      gh
      unzip
      ripgrep
      rsync
      imagemagick
      killall
      bandwhich
      grex
      fd
      xh
      jq
      lm_sensors
      dconf
      xorg.xhost
      cachix
      glib
      docker-compose
      alsa-lib
      alsa-plugins
      alsa-utils
      nixopsUnstable
      xdg-user-dirs
      xdg-utils

      # Language servers
      go
      gcc
      rustc
      cargo
      ccls
      rnix-lsp
      rust-analyzer
      shellcheck
      sumneko-lua-language-server

      # Formatters
      black
      ktlint
      nixfmt
      nixpkgs-fmt
      rustfmt
      shfmt
    ];

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      EDITOR = "${pkgs.neovim}/bin/nvim";
      GOPATH = "${config.home.homeDirectory}/Extras/go";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    };
  };
}
