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

    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
    };

    initExtra = ''
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
      _comp_options+=(globdots)
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
      tree = "${getExe eza} --tree --icons --tree";
      untar = "tar -xvf";
      untargz = "tar -xzf";
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
