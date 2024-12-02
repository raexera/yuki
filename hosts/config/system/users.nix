{
  users.users.raexera = {
    isNormalUser = true;
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
