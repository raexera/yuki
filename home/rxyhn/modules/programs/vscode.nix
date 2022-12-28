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
        sumneko.lua
        timonwong.shellcheck
        usernamehw.errorlens
        vadimcn.vscode-lldb
        xaver.clang-format
        yzhang.markdown-all-in-one
        _2gua.rainbow-brackets
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "decay";
          publisher = "decaycs";
          version = "1.0.5";
          sha256 = "sha256-UKPGopCNY0A4J+E9Egu1lhM7woDW+4lNOs3L1CfQq+0=";
        }
        {
          name = "copilot-nightly";
          publisher = "github";
          version = "1.61.7476";
          sha256 = "sha256-QBGxt+uMbk6E86HFzgPl1iFC7VVFTkQV6VNqpChFI0A=";
        }
        {
          name = "vscode-lua-format";
          publisher = "koihik";
          version = "1.3.8";
          sha256 = "sha256-ACdjiy+Rj2wmxvSojaJmtCwyryWWB+OA/9hBEMJi39g=";
        }
      ];

    userSettings = {
      "workbench.colorTheme" = "Dark Decay Theme";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontFamily" = "'monospace', monospace, Material Symbols Outlined";
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
      "editor.defaultFormatter" = "Koihik.vscode-lua-format";
      "vscode-lua-format.binaryPath" = "${pkgs.luaFormatter}/bin/lua-format";
      "vscode-lua-format.configPath" = "${config.xdg.configHome}/LuaFormatter.cfg";
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
    };
  };

  xdg.configFile."LuaFormatter.cfg".text = ''
    indent_width: 4
    use_tab: false
    keep_simple_control_block_one_line: false
    keep_simple_function_one_line: false
    single_quote_to_double_quote: true
    chop_down_table: true
    chop_down_kv_table: true
  '';
}
