{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      code = "$HOME/Documents/code";
      dots = "$HOME/Documents/code/yuki";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
    };

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
    };

    completionInit = ''
      # Load Zsh modules
      autoload -U compinit
      zmodload zsh/complist

      # General completion behavior
      zstyle ':completion:*' menu yes select # search
      zstyle ':completion:*' sort false
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''

      # Matcher and completer configurations
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric

      # Formatting and colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Specific behaviors for types of completions
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
      zstyle ':completion:*:jobs' numbers true
      zstyle ':completion:*:jobs' verbose true
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:files' sort false
    '';

    initExtra = ''
      # Set options
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
      COMPLETE_IN_WORD
      CORRECT
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
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
      NO_NOMATCH
      PUSHD_IGNORE_DUPS
      PUSHD_TO_HOME
      PUSHD_SILENT
      SHARE_HISTORY
      EOF

      # Unset options
      while read -r option; do
        unsetopt $option
      done <<-EOF
      CORRECT_ALL
      HIST_BEEP
      MENU_COMPLETE
      EOF

      # Load Zsh modules
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      # Initialize completion system
      _comp_options+=(globdots)
      compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

      # Colors configuration
      autoload -Uz colors && colors

      # Autosuggestion and syntax highlighting settings
      ZSH_AUTOSUGGEST_USE_ASYNC="true"
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor regexp root line)
      ZSH_HIGHLIGHT_MAXLENGTH=512

      # Vi mode key bindings
      bindkey -v
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line
    '';

    shellAliases = with lib;
    with pkgs; {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      cat = "${getExe bat} --style=plain";
      du = getExe du-dust;
      fzf = getExe skim;
      ga = "forgit_add";
      gbd = "forgit_branch_delete";
      gbl = "forgit_blame";
      gcb = "forgit_checkout_branch";
      gcf = "forgit_checkout_file";
      gclean = "forgit_clean";
      gco = "forgit_checkout_commit";
      gcp = "forgit_cherry_pick";
      gct = "forgit_checkout_tag";
      gd = "forgit_diff";
      gfu = "forgit_fixup";
      gi = "forgit_ignore";
      glo = "forgit_log";
      grb = "forgit_rebase";
      grc = "forgit_revert_commit";
      grep = getExe ripgrep;
      grh = "forgit_reset_head";
      gsp = "forgit_stash_push";
      gss = "forgit_stash_show";
      la = "${getExe eza} -lah --tree";
      ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      ps = getExe procs;
      run = "nix run $@";
      search = "nix search $@";
      shell = "nix shell $@";
      tree = "${getExe eza} --tree --icons --tree";
      untar = "tar -xvf";
      untargz = "tar -xzf";
    };

    plugins = with pkgs; [
      {
        name = "forgit";
        file = "share/forgit/forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "d7f88d75b6cb3b2bd95f5a2351a3ee79d35a35f9";
          sha256 = "sha256-WHhyllOr/PgR+vlrfMQs/3/d3xpmDylT6BlLCu50a2g=";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
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
