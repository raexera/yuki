{
  config,
  pkgs,
  ...
}: {
  users.users.rxyhn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "systemd-journal"
      "libvirtd"
      "docker"
      "audio"
      "video"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "nixos";
  };
}
