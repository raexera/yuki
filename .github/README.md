<!-- Rxyhn's dotfiles -->
<!-- https://github.com/rxyhn/dotfiles -->

[![NixOS](https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos)](https://github.com/nixos/nixpkgs)

[![NixOS_Check](https://github.com/rxyhn/dotfiles/actions/workflows/check.yml/badge.svg)](https://github.com/rxyhn/dotfiles/actions/workflows/check.yml) [![NixOS_Fmt](https://github.com/rxyhn/dotfiles/actions/workflows/fmt.yml/badge.svg)](https://github.com/rxyhn/dotfiles/actions/workflows/fmt.yml)

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

<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="900px" />
  <img src="https://user-images.githubusercontent.com/93292023/208360860-c0fb98a7-9e48-46ac-bcb6-12839ca21b2e.png" width="900px" alt="NixOS Desktop"/>
</p>

<br>

</div>

<br>
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

3. Switch to root user: `sudo su -`
  
4. Partitioning

    We create a 1024MB EFI boot partition (`/dev/nvme0n1p1`) and the rest will be our LUKS encrypted physical volume for LVM (`/dev/nvme0n1p2`).
    ```bash
    $ gdisk /dev/nvme0n1
    ```
    - `o` (create new empty partition table)
    - `n` (add partition, 1024M, type ef00 EFI)
    - `n` (add partition, remaining space, type 8e00 Linux LVM)
    - `w` (write partition table and exit)
    
    Setup the encrypted LUKS partition and open it:
    ```bash
    $ cryptsetup luksFormat /dev/nvme0n1p2
    $ cryptsetup config /dev/nvme0n1p2 --label cryptroot
    $ cryptsetup luksOpen /dev/nvme0n1p2 enc-pv
    ```

    We create two logical volumes, a 24GB swap parition and the rest will be our root filesystem
    ```bash
    $ pvcreate /dev/mapper/enc-pv
    $ vgcreate vg /dev/mapper/enc-pv
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
    $ nixos-install --flake github:rxyhn/dotfiles#lenovo --impure
    ```

<br>
<br>
<br>

## :busts_in_silhouette: <samp>People</samp>

<table align="right">
  <tr>
    <th align="center">
      <sup><sub>:warning:</sub></sup>
    </th>
  </tr>
  <tr>
    <td align="center">
        <sup><sub><samp>If you stole something from here at least give us credits!</samp></sub></sup>
      </a>
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

 **These are the people who build and maintain this repository.**

 **[rxyhn](https://github.com/rxyhn) - [sioodmy](https://github.com/sioodmy) - [fufexan](https://github.com/fufexan)</b>**

<br>
<br>
<br>

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>

<p align="center"><a href="https://github.com/rxyhn/dotfiles/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=flat&label=License&message=MIT&logoColor=cdd6f4&colorA=1e1e2e&colorB=cba6f7"/></a></p>

</div>
