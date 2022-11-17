{
  lib,
  inputs,
  pkgs,
  config,
  ...
}: let
  mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
      sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
    };
  });
in {
  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      todo
      mpv-unwrapped
      pavucontrol
      imv
      hyperfine
      fzf
      gum
      glxinfo
      ghq
      gh
      unzip
      gnupg
      ripgrep
      rsync
      imagemagick
      killall
      bandwhich
      grex
      fd
      cinnamon.nemo
      xh
      jq
      lm_sensors
      dconf
      go
      gcc
      rustc
      cargo
      xdg-user-dirs
      zoom-us

      # CLI utils
      xorg.xhost
      cachix
      glib
      docker-compose
      alsa-utils
      nixopsUnstable

      # Language servers
      ccls
      rnix-lsp
      rust-analyzer
      shellcheck
      sumneko-lua-language-server

      # Formatters
      black
      ktlint
      alejandra
      nixfmt
      nixpkgs-fmt
      rustfmt
      shfmt
    ];
  };

  programs = {
    home-manager.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        pkief.material-icon-theme
        naumovs.color-highlight
        oderwat.indent-rainbow
        ibm.output-colorizer
        shardulm94.trailing-spaces
        usernamehw.errorlens
        github.vscode-pull-request-github
        github.codespaces
        github.copilot
        eamodio.gitlens
        golang.go
        rust-lang.rust-analyzer
        ms-python.python
        ms-vscode-remote.remote-ssh
        yzhang.markdown-all-in-one
        bbenoist.nix
        kamadorueda.alejandra
        formulahendry.code-runner
        christian-kohler.path-intellisense
        ms-azuretools.vscode-docker
      ];
      userSettings = {
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.colorTheme" = "Catppuccin Frappé";
        "editor.fontFamily" = "JetBrainsMono Nerd Font, Material Design Icons";
        "editor.fontSize" = 16;
        "editor.fontLigatures" = true;
        "workbench.fontAliasing" = "antialiased";
        "files.trimTrailingWhitespace" = true;
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
        "window.titleBarStyle" = "custom";
        "terminal.integrated.automationShell.linux" = "nix-shell";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.enableBell" = false;
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.overviewRulerBorder" = false;
        "editor.renderLineHighlight" = "all";
        "editor.inlineSuggest.enabled" = true;
        "editor.smoothScrolling" = true;
        "editor.suggestSelection" = "first";
        "editor.guides.indentation" = false;
        "window.nativeTabs" = true;
        "window.restoreWindows" = "all";
        "window.menuBarVisibility" = "toggle";
        "workbench.panel.defaultLocation" = "right";
        "workbench.editor.tabCloseButton" = "left";
        "workbench.startupEditor" = "none";
        "workbench.list.smoothScrolling" = true;
        "security.workspace.trust.enabled" = false;
        "explorer.confirmDelete" = false;
        "breadcrumbs.enabled" = true;
      };
    };
  };
}
