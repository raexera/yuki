{pkgs, ...}: {
  users.users.raexera = {
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
  };
}
