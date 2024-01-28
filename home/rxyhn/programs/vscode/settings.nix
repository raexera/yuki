{
  config,
  pkgs,
  ...
}: let
  editor = {
    "breadcrumbs.enabled" = true;
    "breadcrumbs.symbolPath" = "last";
    "editor.acceptSuggestionOnEnter" = "smart";
    "editor.autoIndent" = "full";
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.cursorBlinking" = "smooth";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.fontFamily" = "'Fira Code', 'Material Design Icons'";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 13;
    "editor.fontWeight" = "500";
    "editor.formatOnSave" = true;
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
  };

  explorer = {
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
  };

  extensions = {
    "extensions.autoCheckUpdates" = false;
    "update.mode" = "none";
  };

  files = {
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;
  };

  terminal = {
    "terminal.integrated.cursorBlinking" = true;
    "terminal.integrated.cursorStyle" = "line";
    "terminal.integrated.cursorWidth" = 2;
    "terminal.integrated.fontFamily" = "'Fira Code'";
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.minimumContrastRatio" = 1;
    "terminal.integrated.smoothScrolling" = true;
  };

  window = {
    "window.autoDetectColorScheme" = true;
    "window.commandCenter" = false;
    "window.dialogStyle" = "native";
    "window.menuBarVisibility" = "compact";
    "window.titleBarStyle" = "custom";
  };

  workbench = {
    "workbench.colorTheme" = "Catppuccin Macchiato";
    "workbench.editor.enablePreview" = false;
    "workbench.editor.enablePreviewFromQuickOpen" = false;
    "workbench.iconTheme" = "catppuccin-macchiato";
    "workbench.layoutControl.enabled" = false;
    "workbench.panel.defaultLocation" = "right";
    "workbench.productIconTheme" = "icons-carbon";
    "workbench.tree.renderIndentGuides" = "always";
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
  };

  defaultFormatter = {
    "[c]"."editor.defaultFormatter" = "xaver.clang-format";
    "[cpp]"."editor.defaultFormatter" = "xaver.clang-format";
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[java]"."editor.defaultFormatter" = "redhat.java";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[nix]"."editor.defaultFormatter" = "jnoortheen.nix-ide";
    "[python]"."editor.defaultFormatter" = "ms-python.black-formatter";
    "[scss]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };

  git = {
    "git.autofetch" = true;
    "git.enableSmartCommit" = true;
    "gitlens.views.repositories.files.layout" = "tree";
  };

  github = {
    "github.copilot.enable" = {
      "*" = true;
    };
    "github.copilot.editor.enableAutoCompletions" = true;
    "githubPullRequests.pullBranch" = "always";
  };

  path-intellisense = {
    "path-intellisense.autoSlashAfterDirectory" = true;
    "path-intellisense.autoTriggerNextSuggestion" = true;
    "path-intellisense.extensionOnImport" = true;
    "path-intellisense.showHiddenFiles" = true;
  };

  telemetry = {
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
  };

  cpp = {
    "C_Cpp.intelliSenseEngine" = "disabled";
    "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
    "clang-format.executable" = "${pkgs.clang-tools}/bin/clang-format";
    "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
    "makefile.makePath" = "${pkgs.gnumake}/bin/make";
  };

  java = {
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

  nix = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
  };

  python = {
    "pylint.enabled" = true;
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
  };
in {
  xdg.configFile = {
    "Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink ((pkgs.formats.json {}).generate "vscode-user-settings" (
      editor
      // explorer
      // extensions
      // files
      // terminal
      // window
      // workbench
      // defaultFormatter
      // git
      // github
      // path-intellisense
      // telemetry
      // cpp
      // java
      // nix
      // python
    ));
  };
}
