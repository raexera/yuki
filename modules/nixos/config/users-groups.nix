{pkgs, ...}: let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAotW1uf8vPGbr6C+Vhvn2ncMAKBWLfDazw2MBSFmr44 rxyhn.dev@gmail.com"
  ];
in {
  boot.initrd.network.ssh.authorizedKeys = keys;

  users.users.rxyhn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "NixOS";
    openssh.authorizedKeys.keys = keys;
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
    ];
  };
}
