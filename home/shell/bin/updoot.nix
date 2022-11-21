{ pkgs, ... }:

''
  #> Syntax: bash

  # Send to host

  [ -f "$1" ] && op="cat"
  ''${op:-echo} "''${@:-$(cat -)}" \
      | ${pkgs.curl}/bin/curl -sF file='@-' 'http://0x0.st' \
      | tee /dev/stderr \
      | tr -d '\n'      \
      | ${pkgs.xclip}/bin/xclip -sel clip
''
