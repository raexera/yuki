{
  lib,
  pkgs,
  ...
}: let
  generalSettings = {
    # Editor
    "breadcrumbs.enabled" = true;
    "breadcrumbs.symbolPath" = "last";
    "editor.acceptSuggestionOnEnter" = "smart";
    "editor.autoIndent" = "full";
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.fontFamily" = "'Iosevka Matsuri', 'Material Design Icons'";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 13;
    "editor.fontWeight" = "500";
    "editor.formatOnPaste" = true;
    "editor.formatOnSave" = true;
    "editor.formatOnType" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.inlayHints.enabled" = "onUnlessPressed";
    "editor.inlayHints.padding" = true;
    "editor.inlineSuggest.enabled" = true;
    "editor.linkedEditing" = true;
    "editor.lineHeight" = 22;
    "editor.lineNumbers" = "relative";
    "editor.minimap.enabled" = false;
    "editor.minimap.renderCharacters" = false;
    "editor.renderLineHighlight" = "all";
    "editor.renderWhitespace" = "none";
    "editor.semanticHighlighting.enabled" = true;
    "editor.showUnused" = true;
    "editor.smoothScrolling" = true;
    "editor.tabCompletion" = "on";
    "editor.tabSize" = 2;
    "editor.trimAutoWhitespace" = true;
    "editor.wordWrap" = "on";

    # Explorer
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    # Files
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;

    # Terminal
    "terminal.integrated.cursorBlinking" = true;
    "terminal.integrated.cursorStyle" = "line";
    "terminal.integrated.cursorWidth" = 2;
    "terminal.integrated.fontFamily" = "'Iosevka Matsuri Term'";
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.minimumContrastRatio" = 1;
    "terminal.integrated.smoothScrolling" = true;

    # Window
    "window.autoDetectColorScheme" = true;
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";
    "window.zoomLevel" = 1;

    # Workbench
    "workbench.colorTheme" = "Catppuccin Macchiato";
    "workbench.editor.enablePreview" = false;
    "workbench.editor.enablePreviewFromQuickOpen" = false;
    "workbench.iconTheme" = "catppuccin-macchiato";
    "workbench.panel.defaultLocation" = "right";
    "workbench.productIconTheme" = "icons-carbon";
    "workbench.tree.renderIndentGuides" = "always";
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
  };

  formatterSettings = {
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[java]"."editor.defaultFormatter" = "redhat.java";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[less]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
    "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };

  gitSettings = {
    "git.autofetch" = true;
    "git.enableSmartCommit" = true;
    "gitlens.views.repositories.files.layout" = "tree";
  };

  githubSettings = {
    "github.copilot.enable" = {
      "*" = true;
    };
    "github.copilot.editor.enableAutoCompletions" = true;
    "githubPullRequests.pullBranch" = "always";
  };

  goSettings = {
    "gopls" = {
      "ui.semanticTokens" = true;
    };
  };

  javaSettings = {
    "java.configuration.runtimes" = [
      {
        name = "JavaSE-17";
        path = "${pkgs.jdk17}/lib/openjdk";
        default = true;
      }
    ];
    "java.format.settings.profile" = "GoogleStyle";
    "java.jdt.ls.java.home" = "${pkgs.jdk17}/lib/openjdk";
  };

  pythonSettings = {
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
  };
in {
  programs.vscode.userSettings = lib.mkMerge [
    generalSettings
    formatterSettings
    gitSettings
    githubSettings
    goSettings
    javaSettings
    pythonSettings
  ];
}
