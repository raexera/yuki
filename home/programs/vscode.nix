{
  inputs,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      pkief.material-icon-theme
      naumovs.color-highlight
      oderwat.indent-rainbow
      ibm.output-colorizer
      shardulm94.trailing-spaces
      usernamehw.errorlens
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
      "editor.defaultFormatter" = "xaver.clang-format";
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
}
