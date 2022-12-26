{
  description = "Rxyhn's NixOS Configuration with Home-Manager & Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    helix.url = "github:SoraTenshi/helix/experimental";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # Non Flakes
    sf-mono-liga = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    luaFormatter = {
      type = "git";
      url = "https://github.com/Koihik/LuaFormatter.git";
      submodules = true;
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    filterNixFiles = k: v: v == "regular" && lib.hasSuffix ".nix" k;
    importNixFiles = path:
      (lib.lists.forEach (lib.mapAttrsToList (name: _: path + ("/" + name))
          (lib.filterAttrs filterNixFiles (builtins.readDir path))))
      import;

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowBroken = true;
        allowUnfree = true;
        tarball-ttl = 0;
      };
      overlays = with inputs;
        [
          (
            final: _: let
              inherit (final) system;
            in
              {
                # Packages provided by flake inputs
                crane-lib = crane.lib.${system};
              }
              // (with nixpkgs-f2k.packages.${system}; {
                # Overlays with f2k's repo
                awesome = awesome-git;
                picom = picom-git;
                wezterm = wezterm-git;
              })
              // {
                # Non Flakes
                sf-mono-liga-src = sf-mono-liga;
                firefox-gnome-theme-src = firefox-gnome-theme;
                luaFormatter-src = luaFormatter;
              }
          )
          nur.overlay
          nixpkgs-wayland.overlay
          nixpkgs-f2k.overlays.default
          rust-overlay.overlays.default
        ]
        # Overlays from ./overlays directory
        ++ (importNixFiles ./overlays);
    };
  in rec {
    inherit lib pkgs;

    # nixos modules
    nixosModules = import ./modules/nixos;

    # nixos-configs with home-manager
    nixosConfigurations = import ./hosts inputs;

    # dev shell (for direnv)
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        git
      ];
      name = "dotfiles";
    };

    # Default formatter for the entire repo
    formatter.${system} = pkgs.${system}.alejandra;
  };
}
