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
      gcc
      docker-compose
      alsa-lib
      alsa-plugins
      alsa-utils
      nixopsUnstable
      xdg-user-dirs
      xdg-utils

      # Language servers
      nil
      sumneko-lua-language-server
      go
      gopls
      ccls
      uncrustify
      (rust-bin.selectLatestNightlyWith
        (toolchain: toolchain.default))
      rust-analyzer
      shellcheck
      nodejs
      nodePackages.pyright
      nodePackages.prettier
      nodePackages.stylelint
      nodePackages.jsonlint
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.node2nix

      # Formatters
      black
      ktlint
      stylua
      shfmt
      asmfmt
      nixfmt
      nixpkgs-fmt
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

  imports = [
    ../../gtk

    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/firefox.nix
    ../../programs/mpd.nix
    ../../programs/zathura.nix
  ];
}
