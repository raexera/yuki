{
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        bbenoist.nix
        catppuccin.catppuccin-vsc
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        github.copilot
        golang.go
        ibm.output-colorizer
        kamadorueda.alejandra
        ms-azuretools.vscode-docker
        ms-vscode.cpptools
        naumovs.color-highlight
        oderwat.indent-rainbow
        pkief.material-icon-theme
        shardulm94.trailing-spaces
        sumneko.lua
        usernamehw.errorlens
        vadimcn.vscode-lldb
        xaver.clang-format
        yzhang.markdown-all-in-one
        _2gua.rainbow-brackets
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "stylua";
          publisher = "johnnymorganz";
          version = "1.4.0";
          sha256 = "sha256-0hdjyQbBbo4NblG6VH339sN/oPQEGDtGjJSyHdM4JCM=";
        }
      ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "blue";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontFamily" = "'monospace', monospace, Material Symbols Rounded";
      "editor.fontSize" = 16;
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
      "stylua.styluaPath" = "${pkgs.stylua}/bin/stylua";
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
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "git.enableCommitSigning" = true;
      "git.verboseCommit" = true;
      "[c]" = {
        "editor.defaultFormatter" = "xaver.clang-format";
      };
      "[cpp]" = {
        "editor.defaultFormatter" = "xaver.clang-format";
      };
      "[lua]" = {
        "editor.defaultFormatter" = "johnnymorganz.stylua";
      };
    };
  };

  xdg.configFile.".stylua.toml".text = ''
    column_width = 120
    line_endings = "Unix"
    indent_type = "Spaces"
    indent_width = 2
    quote_style = "AutoPreferDouble"
    call_parentheses = "Always"
    collapse_simple_statement = "Always"
  '';
}
