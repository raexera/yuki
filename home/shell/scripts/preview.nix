{pkgs, ...}: let
  preview = pkgs.writeShellScriptBin "preview" ''
    [ "$1" = "" ] && exit 1

    handle_image() {
      case "$1" in
        image/jpeg|image/png) ${pkgs.chafa}/bin/chafa "$2" ;;
        *) ${pkgs.exiftool}/bin/exiftool -All "$2" ;;
      esac
    }

    handle_text() {
      case "$2" in
        *.md) ${pkgs.glow}/bin/glow --style=auto "$2" ;;
        *.htm|*.html) ${pkgs.elinks}/bin/elinks -dump "$2" ;;
        *) ${pkgs.bat}/bin/bat --theme=base16 --color=always --paging=never --number --italic-text=never --tabs=2 --wrap=never "$2" ;;
      esac
    }

    mime="$(file --brief --mime-type "$1")"
    case "$mime" in
      text/*) handle_text "$mime" "$1" ;;
      inode/directory) ${pkgs.eza}/bin/eza --long --icons --color=always "$1" ;;
      inode/symlink) printf "Symbolic link to: \e[34m%s\e[0m." "$(readlink "$1")" ;;
      application/json) ${pkgs.jq}/bin/jq --color-output < "$1" ;;
      application/x-bittorrent) ${pkgs.transmission}/bin/transmission-show --unsorted "$1" ;;
      application/x-executable|application/x-pie-executable|application/x-sharedlib) ${pkgs.binutils}/bin/readelf --wide --demangle=auto --all "$1" ;;
      application/zip) ${pkgs.atool}/bin/atool --list "$1" ;;
      image/*|video/*) handle_image "$mime" "$1" ;;
      *) exit 1 ;;
    esac
  '';
in {
  home.packages = [preview];
}
