{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  marketplace-extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    johnnymorganz.stylua
    ms-python.black-formatter
    ms-python.python
    rvest.vs-code-prettier-eslint
    sndst00m.markdown-github-dark-pack
  ];
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        catppuccin.catppuccin-vsc
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        github.copilot
        golang.go
        kamadorueda.alejandra
        mkhl.direnv
        ms-python.vscode-pylance
        ms-vscode.cpptools
        naumovs.color-highlight
        oderwat.indent-rainbow
        pkief.material-product-icons
        pkief.material-icon-theme
        oderwat.indent-rainbow
        sumneko.lua
        usernamehw.errorlens
        vadimcn.vscode-lldb
        xaver.clang-format
      ]
      ++ marketplace-extensions;

    userSettings = {
      breadcrumbs.enabled = false;
      emmet.useInlineCompletions = true;
      github.copilot.enable."*" = true;
      security.workspace.trust.enabled = false;
      black-formatter.path = lib.getExe pkgs.black;
      stylua.styluaPath = lib.getExe pkgs.stylua;
      nix.serverPath = lib.getExe inputs.nil.packages.${pkgs.system}.default;
      Lua.misc.executablePath = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";

      "[c]".editor.defaultFormatter = "xaver.clang-format";
      "[cpp]".editor.defaultFormatter = "xaver.clang-format";
      "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[html]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[javascript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[lua]".editor.defaultFormatter = "johnnymorganz.stylua";
      "[nix]".editor.defaultFormatter = "kamadorueda.alejandra";
      "[rust]".editor.defaultFormatter = "rust-lang.rust-analyzer";
      "[scss]".editor.defaultFormatter = "sibiraj-s.vscode-scss-formatter";
      "[typescript]".editor.defaultFormatter = "rvest.vs-code-prettier-eslint";
      "[python]".editor = {
        defaultFormatter = "ms-python.black-formatter";
        formatOnType = true;
      };

      editor = {
        cursorBlinking = "smooth";
        cursorSmoothCaretAnimation = "on";
        cursorWidth = 2;
        find.addExtraSpaceOnTop = false;
        fontFamily = "'Phosphor', 'monospace', monospace";
        fontSize = 16;
        formatOnSave = true;
        inlayHints.enabled = "off";
        inlineSuggest.enabled = true;
        largeFileOptimizations = false;
        lineNumbers = "on";
        linkedEditing = true;
        maxTokenizationLineLength = 60000;
        minimap.enabled = false;
        overviewRulerBorder = false;
        quickSuggestions.strings = true;
        renderWhitespace = "none";
        renderLineHighlight = "all";
        smoothScrolling = true;
        suggest.showStatusBar = true;
        suggestSelection = "first";

        bracketPairColorization = {
          enabled = true;
          independentColorPoolPerBracketType = true;
        };

        guides = {
          bracketPairs = true;
          indentation = true;
        };
      };

      explorer = {
        confirmDragAndDrop = false;
        confirmDelete = true;
      };

      files = {
        eol = "\n";
        insertFinalNewline = true;
        trimTrailingWhitespace = true;
      };

      git = {
        autofetch = true;
        confirmSync = false;
        enableSmartCommit = true;
      };

      terminal.integrated = {
        cursorBlinking = true;
        cursorStyle = "line";
        cursorWidth = 2;
        fontFamily = "'monospace'";
        fontSize = 16;
        smoothScrolling = true;
      };

      window = {
        menuBarVisibility = "toggle";
        nativeTabs = true;
        titleBarStyle = "custom";
        zoomLevel = 1;
      };

      workbench = {
        colorTheme = "Catppuccin Macchiato";
        editor.tabCloseButton = "left";
        iconTheme = "material-icon-theme";
        list.smoothScrolling = true;
        panel.defaultLocation = "right";
        productIconTheme = "material-product-icons";
        smoothScrolling = true;
      };
    };
  };
}
