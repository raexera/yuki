{
  lib,
  pkgs,
  ...
}: ''
  [ "$1" = "" ] && exit 1

  handle_image() {
    case "$1" in
      image/jpeg|image/png) ${lib.getExe pkgs.chafa} "$2" ;;
      *) ${lib.getExe pkgs.exiftool} -All "$2" ;;
    esac
  }

  handle_text() {
    case "$2" in
      *.md) ${lib.getExe pkgs.glow} --style=auto "$2" ;;
      *.htm|*.html) ${lib.getExe pkgs.elinks} -dump "$2" ;;
      *) ${lib.getExe pkgs.bat} --theme=base16 --color=always --paging=never --number --italic-text=never --tabs=2 --wrap=never "$2" ;;
    esac
  }

  mime="$(${lib.getExe pkgs.file} --brief --mime-type "$1")"
  case "$mime" in
    text/*) handle_text "$mime" "$1" ;;
    inode/directory) ${lib.getExe pkgs.eza} --long --icons --color=always "$1" ;;
    inode/symlink) printf "Symbolic link to: \e[34m%s\e[0m." "$(readlink "$1")" ;;
    application/json) ${lib.getExe pkgs.jq} --color-output < "$1" ;;
    application/zip) ${lib.getExe pkgs.atool} --list "$1" ;;
    image/*|video/*) handle_image "$mime" "$1" ;;
    *) exit 1 ;;
  esac
''
