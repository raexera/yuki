<div align="justify">
<div align="center">

<p align="center">
  <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-text-below.svg" width="400px">
</p>

```ocaml
NixOS / Wayland / Hyprland
```

</div>
</div>

<br>

## NixOS Setup
1. Get the latest [NixOS ISO](https://nixos.org/download.html) and boot into the installer/environment.
2. Format and mount your disks.
3. Follow these commands:
    ```bash
    # Switch to root user:
    sudo su -

    # Get into a Nix shell with Nix unstable and git
    nix-shell -p git nixUnstable

    # Clone my dotfiles
    git clone https://github.com/rxyhn/dotfiles /mnt/etc/nixos

    # Remove this file
    rm /mnt/etc/nixos/hosts/akagami/hardware-configuration.nix

    # Generate a config and copy the hardware configuration, disregarding the generated configuration.nix
    nixos-generate-config --root /mnt
    cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/akagami/
    rm /mnt/etc/nixos/configuration.nix

    # Make sure you're in the configuration directory
    cd /mnt/etc/nixos

    # Install this NixOS configuration with flakes
    nixos-install --flake '.#akagami'
    ```
4. Reboot, login as root, and change the password for your user using `passwd <username>`.
5. Log in as your normal user.

<br>

## Special thanks to:
1. [sioodmy](https://github.com/sioodmy)
2. [paulhersch](https://github.com/paulhersch)
3. [javacafe01](https://github.com/javacafe01)

<br>

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center"><a href="https://github.com/rxyhn/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=GPL-3.0&logoColor=d9e0ee&colorA=303446&colorB=f4b8e4"/></a></p>