<!-- Rxyhn's yuki -->
<!-- https://github.com/rxyhn/yuki -->

# YUKI

![NixOS logo](https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png)

## :snowflake: Quick Info on NixOS

NixOS is a unique Linux distribution using the Nix package system. This system lets users install and update software in separate areas, allowing multiple versions of software to be installed at once.

In NixOS, configuration files (called Nix expressions) manage system and app settings differently than in other Unix systems. These files are used for setting up and adjusting software and system components.

NixOS is efficient in managing settings due to these Nix expressions. They enable easy setup duplication, consistent configuration across devices, and flexible modification of settings.

However, NixOS can be challenging to learn, especially in how it handles package management and system settings, which is different from other Linux distributions.

Key benefits of NixOS include:

1. **Reproducibility**: Isolated environments for each package allow for precise installations and easy duplication on other systems.
2. **Consistent Configuration**: Centralized configuration file for uniform setup across machines.
3. **Rollback Feature**: Easy reversal to previous settings if needed.
4. **Modularity**: Simplifies organizing and reusing configurations.
5. **Easy Application Management**: Separate installation areas for software, preventing system issues.
6. **Active Community**: Helpful community for support and troubleshooting.

Overall, NixOS is great for those who want control over their system configurations, offering consistency and ease in managing software, despite its learning curve.

## :wrench: Installation

I highly recommend creating your own configurations based on these dotfiles. Use this repository as a reference to customize your setup according to your preferences and requirements. Please note that these dotfiles were created for my specific hardware configuration, so use them at your own risk.

But anyway… let's move on to the installation process!

1. Download iso

   ```sh
   wget -O nixos.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

   # Write it to a flash drive
   cp nixos.iso /dev/sdX
   ```

2. Boot into the installer.

3. Switch to root user: `sudo -i`

4. Enable flakes

   ```bash
    nix-shell -p nixFlakes
   ```

5. Install nixos from flake

   ```bash
    nixos-install --flake 'github:rxyhn/yuki#lenovo'
   ```

6. Reboot, login as root, and change the password for your user using passwd

7. Log in as your normal user.

8. Install the home manager configuration

   ```bash
    home-manager switch --flake 'github:rxyhn/yuki#rxyhn@lenovo'
   ```

## :bulb: Acknowledgements

Other dotfiles

- [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [sioodmy/dotfiles](https://github.com/sioodmy/dotfiles)

</div>
