{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.rxyhn = {
    description = "Rayhan Pratama";
    initialPassword = "nixos";
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "input"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "wireshark"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
      ];

    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIaeDlsQNZuf95V5QNjfV8eZncS3J0kV4EWvOlcavjh rxyhn@lenovo"];
    packages = [pkgs.home-manager];
  };

  home-manager.users.rxyhn = import ../../../home/rxyhn/${config.networking.hostName};
}
