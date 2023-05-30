{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Shared configuration
    ../shared
    ../shared/optional/programs/alacritty.nix
    ../shared/optional/programs/firefox.nix
    ../shared/optional/programs/mpd.nix
    ../shared/optional/programs/vscode.nix

    # Specific configuration
    ./desktop
    ./services
    ./X
  ];
}
