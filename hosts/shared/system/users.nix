{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;
  users.users.rxyhn = {
    description = "Rayhan Pratama";
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "nixos";
    extraGroups =
      [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "nix"
        "systemd-journal"
      ]
      ++ ifTheyExist [
        "docker"
        "podman"
        "git"
        "libvirtd"
        "mysql"
      ];
    uid = 1000;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIaeDlsQNZuf95V5QNjfV8eZncS3J0kV4EWvOlcavjh rxyhn@lenovo"];
  };
}
