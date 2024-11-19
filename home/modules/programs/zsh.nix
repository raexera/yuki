{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";

    dirHashes = {
      dev = "$HOME/Dev";
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      dots = "$HOME/.yuki";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
    };

    enableCompletion = true;

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    completionInit = ''
      zmodload zsh/complist
      autoload -U compinit; compinit
      _comp_options+=(globdots) # With hidden file-sort
    '';

    initExtra = ''
      while read -r option; do
        setopt $option
      done <<-EOF
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      APPEND_HISTORY
      ALWAYS_TO_END
      CDABLE_VARS
      COMPLETE_IN_WORD
      CORRECT
      EXTENDED_GLOB
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
      HIST_FIND_NO_DUPS
      HIST_FCNTL_LOCK
      HIST_IGNORE_ALL_DUPS
      HIST_IGNORE_DUPS
      HIST_IGNORE_SPACE
      HIST_REDUCE_BLANKS
      HIST_SAVE_NO_DUPS
      HIST_VERIFY
      INC_APPEND_HISTORY
      INTERACTIVE_COMMENTS
      MENU_COMPLETE
      NOBEEP
      NO_NOMATCH
      PUSHD_IGNORE_DUPS
      PUSHD_TO_HOME
      PUSHD_SILENT
      SHARE_HISTORY
      EOF

      while read -r option; do
        unsetopt $option
      done <<-EOF
      CORRECT_ALL
      MENU_COMPLETE
      FLOW_CONTROL
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
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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

    shellAliases = {
      cat = "bat --color=always --theme=base16 --style=plain --paging=never";

      cp = "cp -iv";
      rm = "rm -iv";
      mv = "mv -iv";

      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gc = "git commit -v";
      gcm = "git commit --message";
      gco = "git checkout";
      gd = "git diff";
      gi = "git init";
      gl = "git pull";
      gp = "git push";
      gs = "git status";

      nb = "nix-build";
      nd = "nix develop";
      nr = "nix run";
      ns = "nix-shell";
      nu = "nix-update";
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
