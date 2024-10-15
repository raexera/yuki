{pkgs, ...}: {
  users.users.raexera = {
    isNormalUser = true;
    initialPassword = "NixOS";
    shell = pkgs.zsh;

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
