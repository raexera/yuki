{pkgs, ...}: {
  users.users.rxyhn = {
    isNormalUser = true;
    initialPassword = "NixOS";
    shell = pkgs.zsh;
    uid = 1000;

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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAotW1uf8vPGbr6C+Vhvn2ncMAKBWLfDazw2MBSFmr44 rxyhn.dev@gmail.com"
    ];
  };
}
