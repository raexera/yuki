{ pkgs, ... }:

''
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
''
