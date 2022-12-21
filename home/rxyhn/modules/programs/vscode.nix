{
  inputs,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = ''
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland
      '';
    };
    extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        bbenoist.nix
        catppuccin.catppuccin-vsc
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        golang.go
        ibm.output-colorizer
        kamadorueda.alejandra
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode-remote.remote-ssh
        ms-vscode.cpptools
        naumovs.color-highlight
        oderwat.indent-rainbow
        pkief.material-icon-theme
        rust-lang.rust-analyzer
        shardulm94.trailing-spaces
        timonwong.shellcheck
        usernamehw.errorlens
        vadimcn.vscode-lldb
        xaver.clang-format
        yzhang.markdown-all-in-one
        _2gua.rainbow-brackets
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "copilot-nightly";
          publisher = "github";
          version = "1.61.7476";
          sha256 = "QBGxt+uMbk6E86HFzgPl1iFC7VVFTkQV6VNqpChFI0A=";
        }
      ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "mauve";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontFamily" = "'monospace', monospace";
      "editor.fontSize" = 13;
      "editor.fontLigatures" = true;
      "workbench.fontAliasing" = "antialiased";
      "files.trimTrailingWhitespace" = true;
      "terminal.integrated.fontFamily" = "monospace";
      "window.titleBarStyle" = "custom";
      "terminal.integrated.automationShell.linux" = "nix-shell";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.enableBell" = false;
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
      "editor.guides.indentation" = true;
      "editor.guides.bracketPairs" = true;
      "editor.bracketPairColorization.enabled" = true;
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
}
