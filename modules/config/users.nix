{pkgs, ...}: {
  users.users.raexera = {
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "network"
      "networkmanager"
      "plugdev"
      "libvirtd"
      "mysql"
      "docker"
      "podman"
      "git"
    ];
  };
}
