{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./xdg.nix
    ./zsh.nix
    ./starship.nix
    ./cli.nix
    ./git.nix
    ./nix.nix
  ];

  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/Workspace/go/bin"
    ];

    sessionVariables = {
      GOPATH = "${config.home.homeDirectory}/Workspace/go";
      GOBIN = "${config.home.homeDirectory}/Workspace/go/bin";
    };

    file = {
      ".local/bin/updoot" = {
        # Upload and get link
        executable = true;
        text = ''
          #> Syntax: bash

          # Send to host

          [ -f "$1" ] && op="cat"
          ''${op:-echo} "''${@:-$(cat -)}" \
              | ${pkgs.curl}/bin/curl -sF file='@-' 'http://0x0.st' \
              | tee /dev/stderr \
              | tr -d '\n'      \
              | ${pkgs.xclip}/bin/xclip -sel clip
        '';
      };

      ".local/bin/preview.sh" = {
        # Preview script for fzf tab
        executable = true;
        text = ''
          #> Syntax: bash
          # Copied from Elkowar

          case "$1" in
            -*) exit 0;;
          esac

          case "$(${pkgs.file}/bin/file --mime-type "$1")" in
            *text*)
              ${pkgs.bat}/bin/bat --color always --plain "$1"
              ;;
            *image* | *pdf)
              ${pkgs.catimg}/bin/catimg -w 100 -r 2 "$1"
              ;;
            *directory*)
              ${pkgs.exa}/bin/exa --icons -1 --color=always "$1"
              ;;
            *)
              echo "unknown file format"
              ;;
          esac
        '';
      };
    };
  };
}
