{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.rxyhn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Rayhan Pratama";
    initialPassword = "nixos";
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "wireshark"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
      ];

    uid = 1000;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIaeDlsQNZuf95V5QNjfV8eZncS3J0kV4EWvOlcavjh rxyhn@lenovo"];
    packages = [pkgs.home-manager];
  };

  home-manager.users.rxyhn = import ../../../home/rxyhn/${config.networking.hostName};
}
