{
  pkgs,
  lib,
  config,
  ...
}: let
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
in {
  imports = [./run-as-service.nix];
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = {
      ".local/bin/updoot" = {
        executable = true;
        text = import ./updoot.nix {inherit lib pkgs;};
      };

      ".local/bin/preview" = {
        executable = true;
        text = import ./preview.nix {inherit lib pkgs;};
      };

      ".local/bin/extract" = {
        executable = true;
        text = import ./extract.nix {inherit lib pkgs;};
      };
    };

    packages = [ocrScript];
  };
}
