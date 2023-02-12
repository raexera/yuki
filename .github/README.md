<!-- Rxyhn's yuki -->
<!-- https://github.com/rxyhn/yuki -->

<p align="center">
<a href="https://github.com/nixos/nixpkgs"><img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"></a> <a href="https://awesomewm.org"><img src="https://img.shields.io/static/v1?label=AwesomeWM&message=master&style=flat&logo=awesomewm&colorA=24273A&colorB=8AADF4&logoColor=CAD3F5"/></a>
</p>

<p align="center">
<a href="https://github.com/rxyhn/yuki/actions/workflows/check.yml"><img src="https://github.com/rxyhn/yuki/actions/workflows/check.yml/badge.svg"></a> <a href="https://github.com/rxyhn/yuki/actions/workflows/fmt.yml"><img src="https://github.com/rxyhn/yuki/actions/workflows/fmt.yml/badge.svg"/></a>
</p>

<p align="center">
<a href="https://github.com/rxyhn/yuki/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4"/></a>
</p>

<br>
<br>

<div align="justify">
<div align="center">

```ocaml
Rxyhn's Dotfiles
```

<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png" width="500px" alt="NixOS logo"/>
</p>

<br>

```ocaml
NixOS / Home-Manager / Flake
```

</div>

<br>
<br>
<br>

## :snowflake: <samp>Information</samp>

<div>
<img src="https://raw.githubusercontent.com/awesomeWM/apidoc/gh-pages/images/AUTOGEN_wibox_logo_logo_and_name.svg" align=right />

<table align=left><tr><td>
<b>- Operating System: </b><br />
<b>- Window Manager: </b><br />
<b>- Compositor: </b><br />
<b>- Terminal: </b><br />
<b>- Shell: </b><br />
<b>- Editor: </b><br />
<b>- GPU: </b><br /></table>

<table><tr><td>
<a href="https://nixos.org">NixOS</a><br />
<a href="https://awesomewm.org">AwesomeWM</a><br />
<a href="https://github.com/yshui/picom">Picom</a><br />
<a href="https://wezfurlong.org/wezterm">Wezterm</a><br />
<a href="https://www.zsh.org">ZSH</a><br />
<a href="https://helix-editor.com">Helix</a><br />
<a href="https://www.nvidia.com">Nvidia</a><br /></table>
</div>

<br>
<br>

## :wrench: <samp>Installation</samp>

1. Download iso

   ```sh
   # Yoink nixos-unstable
   wget -O nixos.iso https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

   # Write it to a flash drive
   cp nixos.iso /dev/sdX
   ```

2. Boot into the installer.

3. Switch to root user: `sudo -i`

4. Partitioning

   We create a 512MB EFI boot partition (`/dev/nvme0n1p1`) and the rest will be our LUKS encrypted physical volume for LVM (`/dev/nvme0n1p2`).

   ```bash
   $ gdisk /dev/nvme0n1
   ```

   - `o` (create new empty partition table)
   - `n` (add partition, 512M, type ef00 EFI)
   - `n` (add partition, remaining space, type 8e00 Linux LVM)
   - `w` (write partition table and exit)

   Setup the encrypted LUKS partition and open it:

   ```bash
   $ cryptsetup luksFormat /dev/nvme0n1p2
   $ cryptsetup config /dev/nvme0n1p2 --label cryptroot
   $ cryptsetup luksOpen /dev/nvme0n1p2 enc
   ```

   We create two logical volumes, a 24GB swap parition and the rest will be our root filesystem

   ```bash
   $ pvcreate /dev/mapper/enc
   $ vgcreate vg /dev/mapper/enc
   $ lvcreate -L 24G -n swap vg
   $ lvcreate -l '100%FREE' -n root vg
   ```

   Format partitions

   ```bash
   $ mkfs.fat -F 32 -n boot /dev/nvme0n1p1
   $ mkswap -L swap /dev/vg/swap
   $ swapon /dev/vg/swap
   $ mkfs.btrfs -L root /dev/vg/root
   ```

   Mount partitions

   ```bash
   $ mount -t btrfs /dev/vg/root /mnt

   # Create the subvolumes
   $ btrfs subvolume create /mnt/root
   $ btrfs subvolume create /mnt/home
   $ btrfs subvolume create /mnt/nix
   $ btrfs subvolume create /mnt/log
   $ umount /mnt

   # Mount the directories
   $ mount -o subvol=root,compress=zstd,noatime,ssd,space_cache=v2 /dev/vg/root /mnt
   $ mkdir -p /mnt/{home,nix,var/log}
   $ mount -o subvol=home,compress=zstd,noatime,ssd,space_cache=v2 /dev/vg/root /mnt/home
   $ mount -o subvol=nix,compress=zstd,noatime,ssd,space_cache=v2 /dev/vg/root /mnt/nix
   $ mount -o subvol=log,compress=zstd,noatime,ssd,space_cache=v2 /dev/vg/root /mnt/var/log

   # Mount boot partition
   $ mkdir /mnt/boot
   $ mount /dev/nvme0n1p1 /mnt/boot
   ```

5. Enable flakes

   ```bash
   $ nix-shell -p nixFlakes
   ```

6. Install nixos from flake

   ```bash
   $ nixos-install --flake 'github:rxyhn/yuki#lenovo'
   ```

7. Reboot, login as root, and change the password for your user using passwd

8. Log in as your normal user.

9. Install the home manager configuration
   ```bash
   $ home-manager switch --flake 'github:rxyhn/yuki#rxyhn@lenovo'
   ```

<br>
<br>

## :bulb: <samp>Acknowledgements</samp>

<table align="right">
  <tr>
    <th align="center">
      <sup><sub>:warning: WARNING :warning:</sub></sup>
    </th>
  </tr>
  <tr>
    <td align="center">
        <sup><sub><samp>It worked perfectly on my machine, but I can't guarantee it will work on your machine</samp></sub></sup>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution">
        <sup><sub><samp>Powered by NixOS/Linux x86_64</samp></sub></sup>
      </a>
    </td>
  </tr>
</table>

**Other dotfiles**

- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)
- [Misterio77/nix-config](https://github.com/Misterio77/nix-config)
- [sioodmy/dotfiles](https://github.com/sioodmy/dotfiles)

</div>
