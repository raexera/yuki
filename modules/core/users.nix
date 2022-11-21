{
  config,
  pkgs,
  ...
}: {
  users.users.rxyhn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "docker"
      "systemd-journal"
      "audio"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "nixos";
  };
}
