{pkgs, ...}: let
  # General settings
  editor = {
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
    "editor.inlineSuggest.enabled" = true;
    "editor.linkedEditing" = true;
    "editor.lineHeight" = 22;
    "editor.lineNumbers" = "relative";
    "editor.minimap.enabled" = false;
    "editor.renderLineHighlight" = "all";
    "editor.semanticHighlighting.enabled" = true;
    "editor.showUnused" = true;
    "editor.smoothScrolling" = true;
    "editor.tabCompletion" = "on";
    "editor.tabSize" = 2;
    "editor.trimAutoWhitespace" = true;
  };

  explorer = {
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
  };

  files = {
    "files.insertFinalNewline" = true;
    "files.trimTrailingWhitespace" = true;
  };

  telemetry = {
    "redhat.telemetry.enabled" = false;
    "telemetry.telemetryLevel" = "off";
  };

  terminal = {
    "terminal.integrated.fontSize" = 13;
    "terminal.integrated.smoothScrolling" = true;
  };

  window = {
    "window.autoDetectColorScheme" = true;
    "window.dialogStyle" = "native";
    "window.menuBarVisibility" = "toggle";
    "window.titleBarStyle" = "custom";
  };

  workbench = {
    "workbench.colorTheme" = "Catppuccin Macchiato";
    "workbench.iconTheme" = "catppuccin-macchiato";
    "workbench.panel.defaultLocation" = "right";
    "workbench.productIconTheme" = "icons-carbon";
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
  };

  # Extension specific settings
  git = {
    "git.autofetch" = true;
    "git.enableCommitSigning" = true;
    "git.enableSmartCommit" = true;
  };

  github = {
    "github.copilot.enable" = {
      "*" = true;
    };
    "github.copilot.editor.enableAutoCompletions" = true;
  };

  path-intellisense = {
    "path-intellisense.autoSlashAfterDirectory" = true;
    "path-intellisense.autoTriggerNextSuggestion" = true;
    "path-intellisense.extensionOnImport" = true;
    "path-intellisense.showHiddenFiles" = true;
  };

  # Language specific settings
  # Formatter
  formatter = {
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

  # Shell
  bash = {
    "bashIde.shellcheckPath" = "${pkgs.shellcheck}/bin/shellcheck";
    "shfmt.executablePath" = "${pkgs.shfmt}/bin/shfmt";
  };

  # C/C++
  cpp = {
    "C_Cpp.intelliSenseEngine" = "disabled";
    "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
    "clang-format.executable" = "${pkgs.clang-tools}/bin/clang-format";
    "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
    "makefile.makePath" = "${pkgs.gnumake}/bin/make";
  };

  # Golang
  go = {
    "[go]" = {
      "editor.defaultFormatter" = "golang.go";
      "editor.codeActionsOnSave" = {
        "source.organizeImports" = true;
        "source.fixAll" = true;
      };
    };

    "go.formatTool" = "goimports";
    "go.formatFlags" = [
      "-local"
      "github.com/takt-corp/"
    ];

    "go.lintTool" = "golangci-lint";
    "go.lintOnSave" = "workspace";
    "go.lintFlags" = [
      "--fast"
    ];

    "go.useLanguageServer" = true;
    "gopls" = {
      "ui.completion.usePlaceholders" = true;
      "ui.semanticTokens" = true;
    };
  };

  # Java
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

  # Nix
  nix = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.serverSettings"."nil"."formatting"."command" = ["${pkgs.alejandra}/bin/alejandra"];
  };

  # Python
  python = {
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
    "python.analysis.typeCheckingMode" = "strict";
    "python.analysis.autoFormatStrings" = true;
  };
in {
  programs.vscode.userSettings =
    {
      "extensions.autoCheckUpdates" = false;
      "extensions.ignoreRecommendations" = true;
      "update.mode" = "none";
    }
    # General settings
    // editor
    // explorer
    // files
    // telemetry
    // terminal
    // window
    // workbench
    # Extension specific settings
    // git
    // github
    // path-intellisense
    # Language specific settings
    // formatter
    // bash
    // cpp
    // go
    // java
    // nix
    // python;
}
