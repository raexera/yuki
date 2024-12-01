{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs/bat.nix
    ./programs/dircolors.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/starship.nix
    ./programs/yazi.nix
    ./programs/zoxide.nix
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    enableCompletion = true;

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    historySubstringSearch = {
      enable = true;
      searchUpKey = ["^[[A"];
      searchDownKey = ["^[[B"];
    };

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      size = 10000;
      save = 10000;
      append = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
      share = true;
    };

    completionInit = ''
      zmodload zsh/complist
      autoload -U compinit; compinit
      _comp_options+=(globdots)
    '';

    initExtra = ''
      while read -r option; do
        setopt $option
      done <<-EOF
      ALWAYS_TO_END
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      CDABLE_VARS
      COMPLETE_IN_WORD
      HASH_LIST_ALL
      INTERACTIVE_COMMENTS
      NO_BEEP
      NOTIFY
      PATH_DIRS
      PUSHD_IGNORE_DUPS
      PUSHD_SILENT
      EOF

      while read -r option; do
        unsetopt $option
      done <<-EOF
      FLOW_CONTROL
      MENU_COMPLETE
      EOF

      # Ztyle pattern
      # :completion:<function>:<completer>:<command>:<argument>:<tag>

      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' complete true
      zstyle ':completion:*' complete-options true
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' keep-prefix true
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' verbose true

      zstyle ':completion:*:default' list-prompt '%S%M matches%s'
      zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
      zstyle ':completion:*:descriptions' format '%F{blue}-- %D %d --%f'
      zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
      zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
    '';

    shellAliases = let
      inherit (lib) getExe;
      inherit (pkgs) bat ripgrep dust procs;
    in {
      cat = "${getExe bat} --color=always --theme=base16 --style=plain --paging=never";
      du = "${getExe dust}";
      grep = "${getExe ripgrep}";
      ps = "${getExe procs}";

      cp = "cp -iv";
      rm = "rm -iv";
      mv = "mv -iv";

      nb = "nix-build";
      nd = "nix develop";
      nr = "nix run";
      ns = "nix-shell";
      nu = "nix-update";

      cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      repair = "nix-store --verify --check-contents --repair";
    };

    plugins = with pkgs; [
      {
        name = "zsh-forgit";
        src = zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
}
